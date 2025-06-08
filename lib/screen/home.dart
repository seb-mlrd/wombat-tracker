import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/location_services.dart';
import 'package:wombat_tracker/widget/maps.dart';
import 'package:wombat_tracker/widget/timmer_card.dart';
import 'package:wombat_tracker/widget/weather_card.dart';
import '../widget/wombat_banner.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? lat,long;
  @override
  void initState()
  {
    super.initState();
    getLocation();
  }

  // Future<void> _getLocation() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;

  //   // Vérifie si le service de localisation est activé
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       setState(() {
  //         _status = "Service de localisation non activé.";
  //       });
  //       return;
  //     }
  //   }

  //   // Vérifie les permissions
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       setState(() {
  //         _status = "Permission de localisation refusée.";
  //       });
  //       return;
  //     }
  //   }

  //   // Récupère la position
  //   try {
  //     final locData = await location.getLocation();
  //     setState(() {
  //       _locationData = locData;
  //       _status = "Latitude: ${locData.latitude}, Longitude: ${locData.longitude}";
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _status = "Erreur lors de la récupération de la localisation.";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: primaryBase,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WombatBanner(),
              WeatherCard(),
              SizedBox(height: 64),
              MyTimmer(),
              SizedBox(height: 64),
              SizedBox(
                height: 300,
                child: Maps(),
              ),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  void getLocation() async {
    final service = LocationServices();

    final locationData = await service.getLocation();

    if(locationData != null){
      setState(() {
        lat = locationData.latitude!.toString();
        long = locationData.longitude!.toString();
      });
    }
  }
}
