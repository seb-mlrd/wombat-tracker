import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';

class TimeStickerTraining extends StatelessWidget {
  const TimeStickerTraining({super.key, required this.circuit});

  final List circuit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            circuit.isNotEmpty
                ? "${circuit[0]} MIN - ${circuit[1]} circuit${circuit[1] > 1 ? "s" : ""}"
                : "",
            style: subSubSubTitle.copyWith(color: primaryBase),
          ),
        ],
      ),
    );
  }
}
