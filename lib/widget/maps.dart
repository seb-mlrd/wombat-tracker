// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:wombat_tracker/utils/location_services.dart';

class Maps extends StatefulWidget {
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
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  bool run = false;
  @override
  void initState() {
    super.initState();
    getLocation();
    LocationServices.runReady.addListener(() {
      if (LocationServices.runReady.value) {
        getInitialLocation();
      } else if (!LocationServices.runReady.value && run) {
        print('ouais c\'est michel');
        getFinalLocation();
      }
    });
  }

  void _setPolyline() {
    final List<LatLng> points = [_start];
    if (_end != null) {
      points.add(_end);
    } else {
      points.add(_center);
    }

    final Polyline polyline = Polyline(
      polylineId: PolylineId("route"),
      color: Colors.blueAccent,
      width: 5,
      points: points,
    );

    setState(() {
      _polylines.add(polyline);
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
            infoWindow: InfoWindow(
              title:
                  "lat: ${locationInitialData!.altitude.toString()} and long ${locationInitialData!.longitude.toString()}",
            ),
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
    print(locationData);
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
        _start = LatLng(locationInitialData!.latitude!.toDouble(),locationInitialData!.longitude!.toDouble());
        _markers.add(
          Marker(
            markerId: MarkerId("Position de départ"),
            position: _start,
            infoWindow: InfoWindow(title: "Position de départ"),
          ),
        );
        run = true;
        _setPolyline();
      });
    }

    return locationInitialData;
  }

  Future<LocationData?> getFinalLocation() async {
    final service = LocationServices();
    locationFinalData = await service.getLocation();
    if (locationFinalData != null) {
      setState(() {
        _end = LatLng(locationFinalData!.latitude!.toDouble(),locationFinalData!.longitude!.toDouble());
        _markers.add(
          Marker(
            markerId: MarkerId("Position de fin"),
            position: _end,
            infoWindow: InfoWindow(title: "Position de fin"),
          ),
        );
        run = false;
        _setPolyline();
      });
    }

    return locationInitialData;
  }
}

// pour clear les polylines

// setState(() {
//   _polylines.clear();
//   _polylines.add(polyline);
// });