import 'package:flutter/material.dart';
import 'package:wombat_tracker/screen/auth/login.dart';
import 'package:wombat_tracker/screen/auth/signup.dart';
import 'package:wombat_tracker/styles.dart';

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
    return Scaffold(
      body: _screenList[_currentScreen],
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: primaryBase,
      //   unselectedItemColor: primaryBase,
      //   backgroundColor: secondaryBase,
      //   currentIndex: _currentScreen,
      //   onTap: (index) => {
      //     setState(() {
      //       _currentScreen = index;
      //     }),
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.search_rounded,
      //         size: _currentScreen == 0 ? 43 : 24,
      //       ),
      //       label: 'Signup',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.search_rounded,
      //         size: _currentScreen == 1 ? 43 : 24,
      //       ),
      //       label: 'Login',
      //     ),
      //   ],
      // ),
    );
  }
}
