// lib/profil/thumbnail_user.dart

import 'package:flutter/material.dart';

// styles 
import 'package:wombat_tracker/styles.dart';

// utils 
import 'package:wombat_tracker/utils/services/text_services.dart';

// widget 
import 'package:wombat_tracker/widget/avatar.dart';

class ThumbnailUser extends StatelessWidget {
  final String avatar;
  final String firstName;
  final String lastName;
  final String text;
  final Color colorText;
  final TextStyle fontText;
  const ThumbnailUser({
    super.key,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.text,
    required this.colorText,
    required this.fontText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar(picture: avatar, size: 32),
        SizedBox(width: 16),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextServices.truncate("$firstName $lastName", 24),
                style: fontText.copyWith(color: colorText),
              ),
              SizedBox(height: 8),
              Text(
                text,
                maxLines: 2,
                style: bodyTextMedium.copyWith(color: colorText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
