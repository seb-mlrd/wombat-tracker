import 'package:flutter/material.dart';
import 'package:wombat_tracker/main.dart';
import 'package:wombat_tracker/styles.dart';

class AuthServices {
  static Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if(!context.mounted) return;
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
  }
}
