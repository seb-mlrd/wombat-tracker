import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';

class DescriptionStickerTraining extends StatelessWidget {
  const DescriptionStickerTraining({
    super.key,
    required this.firstTrain,
    required this.secondTrain,
  });

  final String firstTrain;
  final String secondTrain;

  @override
  Widget build(BuildContext context) {
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
}
