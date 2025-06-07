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

  static Future<PostgrestList> getProfilByName(String name) async {
    final List nameSplited = name.split(' ');

    if (nameSplited.length == 1) {
      final lastName = name.trim();
      final response = await supabaseClient
          .from('profil')
          .select()
          .or('firstName.ilike.%$lastName%,lastName.ilike.%$lastName%')
          .neq('userUuid', currentUser!.id);
      return response;
    } else if (nameSplited.length >= 2) {
      final String firstName = nameSplited[0];
      final String lastName = nameSplited[1];
      final response = await supabaseClient
          .from('profil')
          .select()
          .or(
            'firstName.ilike.%$firstName%,lastName.ilike.%$firstName%,firstName.ilike.%$lastName%,lastName.ilike.%$lastName%',
          )
          .neq('userUuid', currentUser!.id);
      return response;
    }
    return [];
  }

  static Future<void> editUser(
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
