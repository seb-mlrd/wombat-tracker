import 'package:flutter/material.dart';

class RedirectLink extends StatelessWidget {
  final String text;
  final Widget to;
  const RedirectLink({super.key, required this.text, required this.to});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => to));
        },
        child: Text(text),
      ),
    );
  }
}
