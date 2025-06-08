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
import 'package:wombat_tracker/utils/friend_relation.dart';
import 'package:wombat_tracker/utils/manage_user.dart';
import 'package:wombat_tracker/utils/text_services.dart';

// widget
import 'package:wombat_tracker/widget/avatar.dart';
import 'package:wombat_tracker/widget/button_cta.dart';
import 'package:wombat_tracker/widget/profil/thumbnail_user.dart';
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
  List<dynamic> profils = [];
  List<dynamic> friends = [];

  @override
  void initState() {
    super.initState();
    profils = widget.profils;
    initializeData();
  }

  Future<void> initializeData() async {
    final fetchedFriends = await FriendRelation.getFriend(profils[0]["id"]);
    setState(() {
      friends = fetchedFriends;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBase,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text('Profil', style: subTitle.copyWith(color: tertiary100)),
                SizedBox(height: 16),
                Avatar(picture: "assets/img/avatar.png", size: 50),
                SizedBox(height: 16),

                infoUser(),

                SizedBox(height: 16),
                if (profils.isNotEmpty)
                  UserBio(bio: profils[0]["bio"] ?? "Aucune bio"),

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
                                    return EditProfil(profils: profils);
                                  },
                                ),
                              ).then((update) async {
                                if (update == true) {
                                  // on met a jour le profil ici si on retourne de la page edit et que l'on a modifier un élément
                                  final updatedProfil =
                                      await ManageUser.getProfil();
                                  setState(() {
                                    profils = updatedProfil;
                                  });
                                }
                              });
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
      margin: EdgeInsets.symmetric(horizontal: 32),
      padding: EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      height: 300,
      decoration: boxDecorationCardProfil(),
      child: listFriends(),
    );
  }

  SingleChildScrollView listFriends() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: friends.isNotEmpty
            ? friends
                  .map(
                    (friend) => Padding(
                      padding: const EdgeInsets.only(left: 24, top: 24),
                      child: ThumbnailUser(
                        avatar: friend["friendId"]["avatar"],
                        firstName: friend["friendId"]["firstName"],
                        lastName: friend["friendId"]["lastName"],
                        text: friend["friendId"]["bio"],
                        colorText: tertiary100,
                        fontText: bodyTextMedium,
                      ),
                    ),
                  )
                  .toList()
            : [
                Text(
                  "Aucun ami",
                  style: bodyTextMedium.copyWith(color: tertiary100),
                ),
              ],
      ),
    );
  }

  Row infoUser() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (profils.isNotEmpty)
          NameUser(
            name: profils[0]["firstName"].toString(),
            lastName: profils[0]["lastName"].toString(),
          ),
        SizedBox(width: 18),
        SizedBox(
          height: 50,
          child: const VerticalDivider(thickness: 2, color: secondaryBase),
        ),
        SizedBox(width: 18),
        if (profils.isNotEmpty) NumberStick(nbStick: profils[0]["nbrStick"]),
      ],
    );
  }

  Container containerBestStat() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
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
}
