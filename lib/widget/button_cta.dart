import 'package:flutter/material.dart';
import '../styles.dart';

class ButtonCta extends StatelessWidget {
  final String keyButton;
  final String labelInput;
  final Future<void> Function() functionCalBack;
  final Color? colorButton;
  final Color colorLabelbutton;
  final BuildContext buildContext;

  const ButtonCta({
    super.key,
    required this.keyButton,
    required this.labelInput,
    required this.functionCalBack,
    required this.colorButton,
    required this.colorLabelbutton,
    required this.buildContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      key: Key(keyButton),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorButton,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          onPressed: functionCalBack,
          child: Text(
            labelInput,
            style: subSubTitle.copyWith(color: colorLabelbutton),
          ),
        ),
      ),
    );
  }
}
