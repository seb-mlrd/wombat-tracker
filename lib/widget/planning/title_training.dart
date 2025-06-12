// lib/planning/title_training.dart

import 'package:flutter/material.dart';

// styles 
import 'package:wombat_tracker/styles.dart';

class TitleTraining extends StatelessWidget {
  const TitleTraining({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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