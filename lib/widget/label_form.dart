import 'package:flutter/material.dart';
import '../styles.dart';


class LabelForm extends StatelessWidget {
  final String labelName;
  const LabelForm({super.key, required this.labelName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 4),
      child: Text(labelName, style: subSubTitle, selectionColor: primaryBase),
    );
  }
}
