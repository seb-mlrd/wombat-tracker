// lib/banner/wombat_banner_screen.dart

import 'package:flutter/material.dart';

// styles 
import '../../styles.dart';

class WombatBannerScreen extends StatelessWidget {
  final bool isLogoActive;
  const WombatBannerScreen({super.key, this.isLogoActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      width: double.infinity,
      padding: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(color: primaryBase),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/img/component1banner.png"),
          isLogoActive
              ? Image.asset("assets/img/logo.png", width: 100)
              : Text(""),
          Image.asset("assets/img/component2banner.png"),
        ],
      ),
    );
  }
}
