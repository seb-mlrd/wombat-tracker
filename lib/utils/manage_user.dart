import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class ManageUser {
  static final SupabaseClient supabaseClient = Supabase.instance.client;
  static User? get currentUser => supabase.auth.currentUser;

  // création d'un utiliateur
  static Future<void> createUser(
    String confEmail,
    String confPassword,
    String confName,
    String confLastName,
  ) async {
    // final AuthResponse res = await supabase.auth.signUp(
    await supabase.auth.signUp(
      email: confEmail,
      password: confPassword,
      // enregistrement des informations de l'utilisateur dans la table Profil
      data: {'firstName': confName, 'lastName': confLastName},
    );

    // final Session? session = res.session;
    // final User? user = res.user;
  }

  static Future<List> getProfil() async {
    final response = await supabaseClient
        .from('profil')
        .select('*')
        .eq('userUuid', currentUser!.id)
        .single();

    return [response];
  }

  static Future<void> editUser(
    // String name,
    // String lastName,
    // String phone,
    // String bio,
    Map data,
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      print(data);
      try {
        await supabaseClient
            .from('profil')
            .update(data)
            .eq('userUuid', currentUser!.id);
      } catch (e) {
        print(e);
      }

      /// appelle de la méthode spuabase pour modifier un user
    }
  }
}
