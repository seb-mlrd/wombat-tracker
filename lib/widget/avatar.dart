import 'package:flutter/material.dart';
import '../styles.dart';

class Avatar extends StatelessWidget {
  final String picture;
  const Avatar({required this.picture, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 50,
      backgroundImage: AssetImage(picture),
      backgroundColor: primary700,
    );
  }
}
