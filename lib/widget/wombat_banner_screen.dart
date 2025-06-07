import 'package:flutter/material.dart';
import '../styles.dart';

class WombatBannerScreen extends StatelessWidget {
  const WombatBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(color: primaryBase),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/img/component1banner.png"),
          Image.asset("assets/img/component2banner.png"),
        ],
      ),
    );
  }
}
