import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';

class TitleStickerTraining extends StatelessWidget {
  const TitleStickerTraining({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      width: 130,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        color: primaryBase,
        child: Text(title, style: addStick.copyWith(color: secondaryBase)),
      ),
    );
  }
}
