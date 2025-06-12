// lib/widget/home/maps.dart

import 'dart:async';
import 'package:flutter/material.dart';

// packge externe
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// utils
import 'package:wombat_tracker/utils/location_services.dart';

class Maps extends StatefulWidget {
  final List<LatLng> points;
  final Function(List<LatLng>) onPointsChanged;
  const Maps({super.key, required this.points, required this.onPointsChanged});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  double? latitude;
  double? longitude;
  late GoogleMapController mapController;
  bool mapControllerReady = false;
  LatLng _center = const LatLng(45.521563, -122.677433);
  late LatLng _start;
  late LatLng _end;
  LocationData? locationInitialData;
  LocationData? locationFinalData;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  late List<LatLng> points;

  Timer? _locationUpdateTimer;
  bool run = false;
  @override
  void initState() {
    super.initState();

    points = List.from(widget.points);

    getLocation();
    LocationServices.runReady.addListener(() {
      if (LocationServices.runReady.value) {
        getInitialLocation();
      } else if (!LocationServices.runReady.value && run) {
        getFinalLocation();
      }
    });
  }

  void startLocationTracking() {
    _locationUpdateTimer = Timer.periodic(Duration(seconds: 10), (timer) async {
      final service = LocationServices();
      final newLocation = await service.getLocation();

      if (newLocation != null) {
        final newPoint = LatLng(
          newLocation.latitude!.toDouble(),
          newLocation.longitude!.toDouble(),
        );

        setState(() {
          points.add(newPoint);

          _polylines.clear();
          _polylines.add(
            Polyline(
              polylineId: PolylineId("route"),
              color: Colors.blueAccent,
              width: 5,
              points: List<LatLng>.from(points),
            ),
          );
          widget.onPointsChanged(points);
        });
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapControllerReady = true;

    if (latitude != null && longitude != null) {
      mapController.animateCamera(CameraUpdate.newLatLng(_center));
    }

    if (latitude != null && longitude != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("Moi"),
            position: LatLng(latitude!, longitude!),
            infoWindow: InfoWindow(title: "Moi"),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: _center, zoom: 15.0),
      polylines: _polylines,
      markers: _markers,
    );
  }

  void getLocation() async {
    final service = LocationServices();

    final locationData = await service.getLocation();
    if (locationData != null) {
      setState(() {
        latitude = locationData.latitude!.toDouble();
        longitude = locationData.longitude!.toDouble();
        _center = LatLng(latitude!, longitude!);

        if (mapControllerReady) {
          mapController.animateCamera(CameraUpdate.newLatLng(_center));
        }

        _markers.add(Marker(markerId: MarkerId("Moi"), position: _center));
      });
    }
  }

  Future<LocationData?> getInitialLocation() async {
    final service = LocationServices();
    locationInitialData = await service.getInitialLocation();
    if (locationInitialData != null) {
      setState(() {
        _start = LatLng(
          locationInitialData!.latitude!.toDouble(),
          locationInitialData!.longitude!.toDouble(),
        );
        _markers.removeWhere((marker) => marker.markerId.value == "Moi");
        _markers.add(
          Marker(
            markerId: MarkerId("Position de départ"),
            position: _start,
            infoWindow: InfoWindow(title: "Position de départ"),
          ),
        );
        run = true;
        points.add(_start);
        startLocationTracking();
      });
    }

    return locationInitialData;
  }

  Future<LocationData?> getFinalLocation() async {
    final service = LocationServices();
    locationFinalData = await service.getLocation();
    if (locationFinalData != null) {
      setState(() {
        _end = LatLng(
          locationFinalData!.latitude!.toDouble(),
          locationFinalData!.longitude!.toDouble(),
        );
        _markers.add(
          Marker(
            markerId: MarkerId("Position de fin"),
            position: _end,
            infoWindow: InfoWindow(title: "Position de fin"),
          ),
        );
        run = false;
        _locationUpdateTimer?.cancel();
      });
    }

    return locationInitialData;
  }
}
