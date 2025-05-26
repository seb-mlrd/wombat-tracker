import 'package:flutter/material.dart';

import 'screen/home.dart';
import 'screen/community.dart';
import 'screen/planning.dart';
import 'screen/profil.dart';
import 'screen/research.dart';


class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final List<Widget> _screenList = const [
    Community(),
    Planning(),
    Home(),
    Profil(),
    Research(),
  ];
  int _currentScreen = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Wombat Tracker')
      ),
      body: _screenList[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        currentIndex: _currentScreen,
        onTap:(index) => {
          setState(() {
            _currentScreen = index;
          })
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.language), label: 'Communauté'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Planning'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Research'),
        ],
      ),

    );
  }
}