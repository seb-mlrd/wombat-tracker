import 'package:flutter/material.dart';
import '../styles.dart';

class WombatBanner extends StatelessWidget {
  const WombatBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(color: primaryBase),
      child: Image.asset('assets/img/Logo.png', fit: BoxFit.contain),
    );
  }
}
