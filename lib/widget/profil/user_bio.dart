// lib/profil/user_bio.dart

import 'package:flutter/material.dart';

// styles 
import '../../styles.dart';

class UserBio extends StatelessWidget {
  final String bio;
  const UserBio({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Center(
        child: Text(
          bio,
          style: bodyTextMedium.copyWith(color: tertiary100),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
