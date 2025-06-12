// lib/planning/continer_sticker.dart

import 'package:flutter/material.dart';

// styles 
import 'package:wombat_tracker/styles.dart';

// widget 
import 'package:wombat_tracker/widget/planning/description_sticker_training.dart';
import 'package:wombat_tracker/widget/planning/time_sticker_training.dart';
import 'package:wombat_tracker/widget/planning/title_sticker_training.dart';

// screen 
import 'package:wombat_tracker/screen/content/sequences_screen.dart';

class ContainerStickerTraining extends StatelessWidget {
  const ContainerStickerTraining({
    super.key,
    required this.titleTraining,
    required this.timeTraining,
    required this.listTrain,
    this.id = 0,
  });

  final String titleTraining;
  final List timeTraining;
  final List listTrain;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: id == 0
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SequencesScreen(
                    idModule: id,
                    timeTraining: titleTraining,
                  ),
                ),
              );
            },
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: primaryBase, width: 2)),
        ),
        child: Stack(
          children: [
            DescriptionStickerTraining(
              firstTrain: listTrain[0],
              secondTrain: listTrain[1],
            ),
            TitleStickerTraining(title: titleTraining),
            TimeStickerTraining(circuit: timeTraining),
          ],
        ),
      ),
    );
  }
}
