import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';

class AppBarWombat extends StatelessWidget implements PreferredSizeWidget {
  final String mainTitle;
  const AppBarWombat({super.key, required this.mainTitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(mainTitle),
      backgroundColor: primaryBase,
      titleTextStyle: subTitle.copyWith(color: secondaryBase),
      toolbarHeight: 86,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(86);
}
