import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/widget/timmer_card.dart';
import 'package:wombat_tracker/widget/weather_card.dart';
import '../widget/wombat_banner.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://github.com/Lyokone/flutterlocation';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Location location = Location();

  Future<void> _showInfoDialog() {

    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Demo Application'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Created by Guillaume Bernos'),
                InkWell(
                  child: const Text(
                    _url,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => launchUrl(Uri.parse(_url)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          ),
        ],
      ),
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
            ],
          ),
        ),
      ),
    );
  }
}