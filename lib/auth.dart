// lib/auth.dart

import 'package:flutter/material.dart';

// screen 
import 'package:wombat_tracker/screen/auth/login.dart';
import 'package:wombat_tracker/screen/auth/signup.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  int _currentScreen = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentScreen == 1
          ? Login(
              onSwitch: () {
                setState(() {
                  _currentScreen = 0;
                });
              },
            )
          : Signup(
              onSwitch: () {
                setState(() {
                  _currentScreen = 1;
                });
              },
            ),
    );
  }
}
