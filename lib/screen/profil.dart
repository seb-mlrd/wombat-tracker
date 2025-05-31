// profil.dart
// package
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// file
import 'package:wombat_tracker/main.dart';

// style
import 'package:wombat_tracker/styles.dart';

// widget
import 'package:wombat_tracker/widget/Avatar.dart';
import '../widget/profil/name_user.dart';
import '../widget/profil/number_stick.dart';
import '../widget/profil/user_bio.dart';

class Profil extends StatefulWidget {
  final User? user;
  final List<dynamic> profils;
  const Profil({super.key, required this.user, required this.profils});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  // List<dynamic> profils = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchProfil();
  // }

  // Future<void> fetchProfil() async {
  //   print('User ID: ${widget.user!.email}');

  //   if (widget.user == null) return;
  //   try {
  //     final response = await supabaseClient
  //         .from('profil')
  //         .select('*')
  //         .eq('userUuid', widget.user!.id)
  //         .single();
  //     print('Response: $response');
  //     setState(() {
  //       profils = [response];
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBase,

      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Text('Profil', style: subTitle.copyWith(color: tertiary100)),
              SizedBox(height: 16),
              Avatar(picture: "img/avatar.png"),
              SizedBox(height: 16),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.profils.isNotEmpty)
                    NameUser(
                      name: widget.profils[0]["firstName"].toString(),
                      lastName: widget.profils[0]["lastName"].toString(),
                    ),
                  SizedBox(width: 18),
                  SizedBox(
                    height: 50,
                    child: const VerticalDivider(
                      thickness: 2,
                      color: secondaryBase,
                    ),
                  ),
                  SizedBox(width: 18),
                  if (widget.profils.isNotEmpty)
                    NumberStick(nbStick: widget.profils[0]["nbrStick"]),
                ],
              ),

              SizedBox(height: 16),
              if (widget.profils.isNotEmpty)
                UserBio(
                  bio: widget.profils[0]["bio"] ?? "Aucune bio",
                  // "Juste un humain qui poursuit ses rêves un pas à la fois - de préférence en portant de jolies chaussures de course ! 🏃‍♂️💨 #RunLaughRepeat #CardioComedian",
                ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: tertiary100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 32,
                        bottom: 16,
                        left: 32,
                      ),
                      child: Text(
                        "Statistiques",
                        style: subTitle.copyWith(color: quinaryBase),
                      ),
                    ),
                  ],
                ),
              ),
              logOut(context),
            ],
          ),
        ),
      ),
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
