// lib/profil/number_stick.dart

import 'package:flutter/material.dart';

// styles 
import '../../styles.dart';

class NumberStick extends StatelessWidget {
  final int nbStick;
  const NumberStick({super.key, required this.nbStick});

  @override
  Widget build(BuildContext context) {
    return Text(
      "baton${nbStick > 1 ? "s" : ""} : $nbStick",
      style: bodyTextMedium.copyWith(color: tertiary100),
    );
  }
}