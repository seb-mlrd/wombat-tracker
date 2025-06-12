// lib/screen/content/end_run.dart

import 'package:flutter/material.dart';

// package externe 
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:geolocator/geolocator.dart';

// styles 
import 'package:wombat_tracker/styles.dart';

// utils 
import 'package:wombat_tracker/utils/services/convert_time.dart';
import 'package:wombat_tracker/utils/network/posts_network.dart';
import 'package:wombat_tracker/utils/network/stats_network.dart';

// widget 
import 'package:wombat_tracker/widget/form/button_cta.dart';
import 'package:wombat_tracker/widget/profil/thumbnail_user.dart';

class EndRun extends StatefulWidget {
  final List<LatLng> points;
  final int timeRun;
  final List<dynamic> profils;

  const EndRun({
    super.key,
    required this.timeRun,
    required this.points,
    required this.profils,
  });

  @override
  State<EndRun> createState() => _EndRunState();
}

class _EndRunState extends State<EndRun> {
  String dateNow = "";
  double speed = 0.0;
  double distance = 0.0;
  late int idStats;

  getDate() {
    DateTime now = DateTime.now();
    setState(() {
      dateNow = DateFormat("EEEE d MMMM y 'à' HH:mm", 'fr_FR').format(now);
    });
  }

  // Fonction pour calculer la distance totale le long des points (en mètres)
  double totalDistance(List<LatLng> points) {
    double total = 0.0;

    for (int i = 0; i < points.length - 1; i++) {
      total += Geolocator.distanceBetween(
        points[i].latitude,
        points[i].longitude,
        points[i + 1].latitude,
        points[i + 1].longitude,
      );
    }

    return total;
  }

  Future<void> sendData(data) async {
    idStats = await StatsNetwork().fetchStats(data);
  }

  Future<void> initialize() async {
    await initializeDateFormatting('fr_FR', null);
    getDate();

    distance = totalDistance(widget.points);
    speed = (distance / 1000) / (widget.timeRun / 3600000);

    if (widget.profils.isEmpty || widget.profils[0]["id"] == null) return;

    List dataRun = [
      {
        "distance": distance.round(),
        "speed": speed,
        "date": dateNow,
        "time": widget.timeRun,
        "idUser": widget.profils[0]["id"],
      },
    ];

    try {
      await sendData(dataRun);
    } catch (e) {
      throw Exception("Envoi échoué : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBase,
      appBar: AppBar(
        backgroundColor: primaryBase,
        title: Text(
          'New Post',
          style: subSubTitle.copyWith(color: quatrenaryBase),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: quatrenaryBase),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ThumbnailUser(
                  avatar: widget.profils[0]["avatar"],
                  firstName: widget.profils[0]["firstName"],
                  lastName: widget.profils[0]["lastName"],
                  text: dateNow.isEmpty ? "Chargement..." : dateNow,
                  colorText: quatrenaryBase,
                  fontText: bodyTextMedium,
                ),
              ),
              Image.asset("assets/img/map_test.png"),
              SizedBox(height: 16),
              Divider(thickness: 2, color: quatrenaryBase),
              SizedBox(height: 16),
              containerData(),
              ButtonCta(
                keyButton: "buttonSharePost",
                labelInput: "Poster",
                functionCallBack: () async {
                  List dataPost = [
                    {
                      "idStats": idStats,
                      "idUserWhoPost": widget.profils[0]["id"],
                    },
                  ];
                  await PostsNetwork().fetchPostsByIdUsers(dataPost);
                  Navigator.pop(context);
                },
                colorButton: quatrenaryBase,
                colorLabelbutton: primaryBase,
                buildContext: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row containerData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [dataDistance(), dataTime(), speedData()],
    );
  }

  Column speedData() {
    return Column(
      children: [
        Text("Vitesse", style: subSubTitle.copyWith(color: quatrenaryBase)),
        Text(
          "${speed.toStringAsFixed(2)} km/h",
          style: subSubTitle.copyWith(color: quatrenaryBase),
        ),
      ],
    );
  }

  Column dataTime() {
    return Column(
      children: [
        Text("Time", style: subSubTitle.copyWith(color: quatrenaryBase)),
        Text(
          ConvertTime().convertTimeToString(widget.timeRun),
          style: subSubTitle.copyWith(color: quatrenaryBase),
        ),
      ],
    );
  }

  Column dataDistance() {
    return Column(
      children: [
        Text("Disatnce", style: subSubTitle.copyWith(color: quatrenaryBase)),
        Text(
          "${(distance / 1000).toStringAsFixed(2)} km",
          style: subSubTitle.copyWith(color: quatrenaryBase),
        ),
      ],
    );
  }
}
