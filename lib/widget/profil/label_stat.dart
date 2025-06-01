import 'package:flutter/material.dart';
import '../../styles.dart';

class LabelStat extends StatelessWidget {
  final String pictureLink;
  final String textStat;

  const LabelStat({
    super.key,
    required this.pictureLink,
    required this.textStat,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(pictureLink),
        SizedBox(width: 10.5),
        Text(textStat, style: bodyTextMedium.copyWith(color: tertiary100)),
      ],
    );
  }
}
