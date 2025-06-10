import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:wombat_tracker/consts.dart';
import 'package:wombat_tracker/styles.dart';

class WeatherCard extends StatefulWidget {
  final double? lat;
  final double? long;

  const WeatherCard({super.key, required this.lat, required this.long});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHE_RAPI_KEY);
  Weather? _weather;
  late double? lat, long;
  @override
  void initState() {
    super.initState();
    initialLatLon();
    initWeather();
    // getLocationLocal();
    // print("⛅");
  }

  void initialLatLon() {
    setState(() {
      lat = widget.lat;
      long = widget.long;
    });
  }

  Future<void> initWeather() async {
    try {
      await _wf.currentWeatherByLocation(widget.lat!, widget.long!).then((w) {
        setState(() {
          _weather = w;
        });
      });
    } catch (e) {
      print("error api weather card : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("Temps"),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Localisation : ${_weather?.areaName ?? ''}",
                  style: subSubTitle,
                ),
                SizedBox(height: 10),
                Text(
                  "Météo : ${_weather?.weatherDescription ?? ''}",
                  style: subSubTitle,
                ),
                SizedBox(height: 10),
                Text(
                  "Température : ${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
                  style: subSubTitle,
                ),
                SizedBox(height: 10),
                Text(
                  "Vitesse du vent : ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                  style: subSubTitle,
                ),
                SizedBox(height: 30),
                if (_weather == null &&
                    widget.lat == null &&
                    widget.long == null)
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    // }
  }

  Widget _label(String text) => Container(
    color: primaryBase,
    padding: EdgeInsets.only(left: 18.0, right: 31.0, top: 4.0, bottom: 9.0),
    child: Text(text, style: addStick.copyWith(color: secondaryBase)),
  );
}
