// lib/profil/name_user.dart

import 'package:flutter/material.dart';

// styles 
import '../../styles.dart';

class NameUser extends StatelessWidget {
  final String name;
  final String lastName;
  const NameUser({super.key, required this.name, required this.lastName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: bodyTextMedium.copyWith(color: tertiary100)),
        SizedBox(height: 10),
        Text(lastName, style: bodyTextMedium.copyWith(color: tertiary100)),
      ],
    );
  }
}
