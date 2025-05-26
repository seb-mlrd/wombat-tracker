import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Text('Home'),
    );
  }
}