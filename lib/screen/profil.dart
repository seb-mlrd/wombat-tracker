// profil.dart
// package
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wombat_tracker/screen/edit_profil.dart';

// file
// import 'package:wombat_tracker/main.dart';

// style
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/auth_services.dart';

// widget
import 'package:wombat_tracker/widget/Avatar.dart';
import 'package:wombat_tracker/widget/button_cta.dart';
import '../widget/profil/name_user.dart';
import '../widget/profil/number_stick.dart';
import '../widget/profil/user_bio.dart';
import '../widget/profil/label_stat.dart';

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
        child: Center(
          child: Column(
            children: [
              Text('Profil', style: subTitle.copyWith(color: tertiary100)),
              SizedBox(height: 16),
              Avatar(picture: "assets/img/avatar.png"),
              SizedBox(height: 16),

              infoUser(),

              SizedBox(height: 16),
              if (widget.profils.isNotEmpty)
                UserBio(bio: widget.profils[0]["bio"] ?? "Aucune bio"),

              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 16),
                decoration: decorationMainContainerStat(),
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
                    containerBestStat(),
                    SizedBox(height: 16),
                    containerFriends(),
                    // logOut(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonCta(
                          keyButton: "Déconnexion",
                          labelInput: "Déconnexion",
                          functionCallBack: () async {
                            await AuthServices.logout(context);
                          },
                          colorButton: senaryBase,
                          colorLabelbutton: tertiary100,
                          buildContext: context,
                        ),
                        ButtonCta(
                          keyButton: "Modifier",
                          labelInput: "Modifier",
                          functionCallBack: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditProfil();
                                },
                              ),
                            );
                          },
                          colorButton: primary200,
                          colorLabelbutton: tertiary100,
                          buildContext: context,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration decorationMainContainerStat() {
    return BoxDecoration(
      color: tertiary100,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
    );
  }

  Container containerFriends() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 48),
      padding: EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      height: 300,
      decoration: boxDecorationCardProfil(),
      child: listFriends(),
    );
  }

  Center listFriends() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Aucun ami", style: bodyTextMedium.copyWith(color: tertiary100)),
        ],
      ),
    );
  }

  Row infoUser() {
    return Row(
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
          child: const VerticalDivider(thickness: 2, color: secondaryBase),
        ),
        SizedBox(width: 18),
        if (widget.profils.isNotEmpty)
          NumberStick(nbStick: widget.profils[0]["nbrStick"]),
      ],
    );
  }

  Container containerBestStat() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 48),
      padding: EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      decoration: boxDecorationCardProfil(),
      child: cardStat(),
    );
  }

  BoxDecoration boxDecorationCardProfil() {
    return BoxDecoration(
      color: primaryBase,
      borderRadius: BorderRadius.circular(16),
    );
  }

  Center cardStat() {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          LabelStat(pictureLink: "assets/img/time.png", textStat: "--:--:--"),
          SizedBox(
            height: 12,
            child: VerticalDivider(thickness: 1, color: secondaryBase),
          ),
          LabelStat(pictureLink: 'assets/img/distance.png', textStat: "-- km"),
          SizedBox(
            height: 12,
            child: VerticalDivider(thickness: 1, color: secondaryBase),
          ),
          LabelStat(pictureLink: 'assets/img/speed.png', textStat: "-- km/h"),
        ],
      ),
    );
  }

  // ElevatedButton logOut(BuildContext context) {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       try {
  //         await supabase.auth.signOut();
  //         if (!mounted) return;
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text("Déconnexion réussie."),
  //             backgroundColor: primary200,
  //           ),
  //         );
  //       } catch (e) {
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
  //       }
  //     },
  //     child: Text("Déconnecter"),
  //   );
  // }
}
