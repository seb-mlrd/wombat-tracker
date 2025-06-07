import 'package:flutter/material.dart';
import '../styles.dart';

class Avatar extends StatelessWidget {
  final String picture;
  final double size;
  const Avatar({super.key, required this.picture, required this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: size,
      backgroundImage: AssetImage(picture),
      backgroundColor: primary700,
    );
  }
}
