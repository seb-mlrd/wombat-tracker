import 'package:flutter/material.dart';
import '../../styles.dart';

class UserBio extends StatelessWidget {
  final String bio;
  const UserBio({super.key, required this.bio});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Text(
        bio,
        style: bodyTextMedium.copyWith(color: tertiary100),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}