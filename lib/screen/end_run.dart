import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/widget/button_cta.dart';
import 'package:wombat_tracker/widget/profil/thumbnail_user.dart';
import 'package:intl/date_symbol_data_local.dart';

class EndRun extends StatefulWidget {
  // final String distance;
  // final String time;
  const EndRun({
    super.key,
    // required this.distance,
    // required this.time,
  });

  @override
  State<EndRun> createState() => _EndRunState();
}

class _EndRunState extends State<EndRun> {
  String dateNow = "";

  getDate() {
    DateTime now = DateTime.now();
    setState(() {
      dateNow = DateFormat("EEEE d MMMM y 'à' HH:mm", 'fr_FR').format(now);
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null).then((_) {
      getDate();
    });
    getDate();
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
                  avatar: "avatar.png",
                  firstName: "james",
                  lastName: "ahmedaly",
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
                  print(dateNow.isEmpty ? "Chargement..." : dateNow);
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
      children: [dataDistance(), dataTime()],
    );
  }

  Column dataTime() {
    return Column(
      children: [
        Text("Time", style: subSubTitle.copyWith(color: quatrenaryBase)),
        Text("5.2 km", style: subSubTitle.copyWith(color: quatrenaryBase)),
      ],
    );
  }

  Column dataDistance() {
    return Column(
      children: [
        Text("Disatnce", style: subSubTitle.copyWith(color: quatrenaryBase)),
        Text("5.2 km", style: subSubTitle.copyWith(color: quatrenaryBase)),
      ],
    );
  }
}
