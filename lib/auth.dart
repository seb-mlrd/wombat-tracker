import 'package:flutter/material.dart';
import 'package:wombat_tracker/screen/auth/login.dart';
import 'package:wombat_tracker/screen/auth/signup.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final List<Widget> _screenList = const [Signup(), Login()];
  final int _currentScreen = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _screenList[_currentScreen]);
  }
}
