import 'package:flutter/material.dart';
import 'package:wombat_tracker/main.dart';
import 'package:wombat_tracker/styles.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(children: [Text('Profil'), logOut(context)]),
    );
  }

  ElevatedButton logOut(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await supabase.auth.signOut();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Déconnexion réussie."),
              backgroundColor: primary200,
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
        }
      },
      child: Text("Déconnecter"),
    );
  }
}
