import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/planning_services.dart';
import 'package:wombat_tracker/widget/wombat_banner_screen.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  List plannings = [];
  void initializeDataPlanning() async {
    final response = await PlanningServices().getPlanning();
    setState(() {
      plannings = response;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDataPlanning();
  }

  @override
  Widget build(BuildContext context) {
    if (plannings.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                WombatBannerScreen(isLogoActive: true),
                title("Renforcement musculaire"),
                for (var planning in plannings)
                  containerStickerTraining(
                    planning['title'],
                    planning["duration"],
                    planning["description"],
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Container containerStickerTraining(
    String titleTraining,
    String timeTraining,
    List listTrain,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: primaryBase, width: 2)),
      ),
      child: Stack(
        children: [
          descriptionStickerTraining(listTrain[0], listTrain[1]),
          titleStickerTraining(titleTraining),
          timeStickerTraining(timeTraining),
        ],
      ),
    );
  }

  Positioned timeStickerTraining(String time) {
    return Positioned(
      top: 8,
      right: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: subSubSubTitle.copyWith(color: primaryBase)),
        ],
      ),
    );
  }

  Positioned titleStickerTraining(String title) {
    return Positioned(
      top: 0,
      left: 0,
      width: 85,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8),
        color: primaryBase,
        child: Text(title, style: addStick.copyWith(color: secondaryBase)),
      ),
    );
  }

  Container descriptionStickerTraining(String firstTrain, String secondTrain) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      color: quatrenaryBase,

      child: Center(
        child: SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  firstTrain,
                  style: subSubSubTitle.copyWith(color: primaryBase),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  secondTrain,
                  style: subSubSubTitle.copyWith(color: primaryBase),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container title(String title) {
    return Container(
      color: primaryBase,
      width: double.infinity,
      height: 100,
      child: Center(
        child: Text(title, style: subSubTitle.copyWith(color: secondaryBase)),
      ),
    );
  }
}
