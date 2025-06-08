import 'dart:developer';

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
  LocationData? locationInitialData;
  LocationData? locationFinalData;
  Set<Marker> _markers = {};
  bool run = false;
  @override
  void initState() {
    super.initState();
    getLocation();
    LocationServices.runReady.addListener(() {
      if (LocationServices.runReady.value) {
        getInitialLocation();
      }else if(!LocationServices.runReady.value && run){
        print('ouais c\'est michel');
          getFinalLocation();
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
            infoWindow: InfoWindow(title: "lat: ${locationInitialData!.altitude.toString()} and long ${locationInitialData!.longitude.toString()}")
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 15.0,
      ),
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
          mapController.animateCamera(
            CameraUpdate.newLatLng(_center),
          );
        }

        _markers.add(
          Marker(
            markerId: MarkerId("Moi"),
            position: _center,
          ),
        );
      });
    }
  }

  Future<LocationData?> getInitialLocation() async {
    final service = LocationServices();
    locationInitialData = await service.getInitialLocation();
    if (locationInitialData != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("Position de départ"),
            position: LatLng(
              locationInitialData!.latitude!.toDouble(),
              locationInitialData!.longitude!.toDouble(),
            ),
            infoWindow: InfoWindow(title: "Position de départ"),
          ),
        );
        run = true;
      });
    }

    return locationInitialData;
  }

  Future<LocationData?> getFinalLocation() async {
    final service = LocationServices();
    locationFinalData = await service.getLocation();
    if (locationFinalData != null) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("Position de fin"),
            position: LatLng(
              locationFinalData!.latitude!.toDouble(),
              locationFinalData!.longitude!.toDouble(),
            ),
            infoWindow: InfoWindow(title: "Position de fin"),
          ),
        );
        run = false;
      });
    }

    return locationInitialData;
  }

}
