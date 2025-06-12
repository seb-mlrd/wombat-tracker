// lib/screen/content/home.dart

import 'package:flutter/material.dart';

// package externe 
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wombat_tracker/utils/location_services.dart';

// styles 
import 'package:wombat_tracker/styles.dart';

// widget 
import 'package:wombat_tracker/widget/home/maps.dart';
import 'package:wombat_tracker/widget/home/timmer_card.dart';
import 'package:wombat_tracker/widget/home/weather_card.dart';
import '../../widget/banner/wombat_banner.dart';

class Home extends StatefulWidget {
  final List<dynamic> profils;

  const Home({super.key, required this.profils});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double? lat, long = 0.0;
  bool isReady = false;

  List<LatLng> points = [];

  // Fonction pour recevoir la liste mise à jour de Maps
  void updatePoints(List<LatLng> newPoints) {
    setState(() {
      points = newPoints;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocationLocal();
  }

  void getLocationLocal() async {
    final locationData = await LocationServices().getLocation();

    if (locationData != null) {
      setState(() {
        lat = locationData.latitude;
        long = locationData.longitude;
        isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: const CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        backgroundColor: primaryBase,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                WombatBanner(),
                WeatherCard(lat: lat, long: long),
                SizedBox(height: 64),
                MyTimmer(points: points, profils: widget.profils),
                SizedBox(height: 64),
                SizedBox(
                  height: 300,
                  child: Maps(points: points, onPointsChanged: updatePoints),
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      );
    }
  }
}
