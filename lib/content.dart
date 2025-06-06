import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/manage_user.dart';
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
  final User? currentUser = ManageUser.currentUser;
  List<dynamic> profils = [];
  late List<Widget> _screenList;
  int _currentScreen = 2;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfil();
  }

  Future<void> fetchProfil() async {
    if (currentUser == null) return;
    try {
      final data = await ManageUser.getProfil();
      profils = data;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      _screenList = [
        const Community(),
        const Planning(),
        const Home(),
        Profil(user: currentUser, profils: profils),
        const Research(),
      ];
      return Scaffold(
        body: _screenList[_currentScreen],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryBase,
          unselectedItemColor: primaryBase,
          backgroundColor: secondaryBase,
          currentIndex: _currentScreen,
          onTap: (index) async {
            if (index == 3) {
              // Si on va sur Profil, on recharge les profils
              final data = await ManageUser.getProfil();
              setState(() {
                profils = data;
                _currentScreen = index;
              });
            } else {
              setState(() {
                _currentScreen = index;
              });
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.language, size: _currentScreen == 0 ? 43 : 24),
              label: 'Communauté',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month_rounded,
                size: _currentScreen == 1 ? 43 : 24,
              ),
              label: 'Planning',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: _currentScreen == 2 ? 43 : 24),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_rounded,
                size: _currentScreen == 3 ? 43 : 24,
              ),
              label: 'Profil',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: _currentScreen == 4 ? 43 : 24,
              ),
              label: 'Research',
            ),
          ],
        ),
      );
    }
  }
}
