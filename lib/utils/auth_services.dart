import 'package:flutter/material.dart';

// styles 
import 'package:wombat_tracker/styles.dart';

// utils 
import 'package:wombat_tracker/utils/manage_user.dart';

import 'package:wombat_tracker/main.dart';

class AuthServices {
  static Future<void> signup(
    Map data,
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      final confPassword = data["password"];
      final confEmail = data["email"];
      final confLastName = data["lastName"];
      final confName = data["name"];
      final confPasswordConfirm = data["confirmPassword"];

      FocusScope.of(context).requestFocus(
        FocusNode(),
      ); // pour retirer le clavier au moment d'envoyer les informations
      if (confPassword != confPasswordConfirm) {
        // Affiche une erreur
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Les mots de passe ne correspondent pas."),
            backgroundColor: senaryBase,
          ),
        );
        return;
      }
      try {
        // utilisation de supabase pour l'inscription
        await ManageUser.createUser(
          confEmail,
          confPassword,
          confName,
          confLastName,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Inscription réussie."),
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

  static Future<void> login(
    Map data,
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      final confPassword = data['password'];
      final confEmail = data['email'];

      FocusScope.of(context).requestFocus(
        FocusNode(),
      ); // pour retirer le clavier au moment d'envoyer les informations

      try {
        // utilisation de supabase pour l'inscription
        await supabase.auth.signInWithPassword(
          email: confEmail,
          password: confPassword,
          // enregistrement des informations de l'utilisateur dans la table Profil
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Connexion réussie."),
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

  static Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return;
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
