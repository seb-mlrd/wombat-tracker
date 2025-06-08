import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    getLocation();
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
            infoWindow: InfoWindow(title: "Moi"),
          ),
        );
      });
    }
  }
}
