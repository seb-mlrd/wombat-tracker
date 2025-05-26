import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';
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
      body: _screenList[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryBase,
        unselectedItemColor: primaryBase,
        backgroundColor: secondaryBase,
        currentIndex: _currentScreen,
        onTap:(index) => {
          setState(() {
            _currentScreen = index;
          })
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.language,
              size:_currentScreen == 0 ?  43 : 24,
            ),
            label: 'Communauté',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month_rounded,
              size:_currentScreen == 1 ?  43 : 24,
            ), 
            label: 'Planning'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size:_currentScreen == 2 ?  43 : 24,
            ), 
            label: 'Accueil'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size:_currentScreen == 3 ?  43 : 24,
            ), 
            label: 'Profil'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
              size:_currentScreen == 4 ?  43 : 24,
            ),
            label: 'Research'
          ),
        ],
      ),

    );
  }
}