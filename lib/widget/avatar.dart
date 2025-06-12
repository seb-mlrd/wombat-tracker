// lib/widget/avatar.dart

import 'package:flutter/material.dart';

// styles 
import '../styles.dart';

class Avatar extends StatelessWidget {
  final String picture;
  final double size;
  const Avatar({super.key, required this.picture, required this.size});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: size,
      backgroundImage: picture == "avatar.png"
          ? AssetImage("assets/img/$picture")
          : NetworkImage(picture),
      backgroundColor: primary700,
    );
  }
}
