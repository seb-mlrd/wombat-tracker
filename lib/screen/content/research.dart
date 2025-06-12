// lib/screen/content/research.dart

import 'package:flutter/material.dart';

// style 
import 'package:wombat_tracker/styles.dart';

// utils 
import 'package:wombat_tracker/utils/friend_relation.dart';
import 'package:wombat_tracker/utils/manage_user.dart';
import 'package:wombat_tracker/utils/services/text_services.dart';
import 'package:wombat_tracker/utils/services/validators.dart';

// widget 
import 'package:wombat_tracker/widget/app_bar_wombat.dart';
import 'package:wombat_tracker/widget/avatar.dart';
import 'package:wombat_tracker/widget/form/input_form.dart';

class Research extends StatefulWidget {
  final List<dynamic> currentUser;
  const Research({super.key, required this.currentUser});

  @override
  State<Research> createState() => _ResearchState();
}

class _ResearchState extends State<Research> {
  final researchBarController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<int> disabledButtons = [];
  List profils = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    final fetchedIdFriends = await FriendRelation.getIdFriend(
      widget.currentUser[0]["id"],
    );
    setState(() {
      for (var fetchedIdFriend in fetchedIdFriends) {
        disabledButtons.add(fetchedIdFriend["friendId"]['id']);
      }
    });
  }

  @override
  void dispose() {
    researchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWombat(mainTitle: 'Rechercher'),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 24),
                textNumberUsersFound(),
                SizedBox(height: 24),

                forSearch(),
                listUsers(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form forSearch() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InputForm(
                nameController: researchBarController,
                typeInput: "recherche",
                methodeValidateInput: (value) => Validators.checkInputEmpty(
                  researchBarController.text,
                  "recherche",
                ),
                paddingHorizontal: 1,
              ),
            ),
            buttonSearch(),
          ],
        ),
      ),
    );
  }

  ElevatedButton buttonSearch() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        backgroundColor: primaryBase,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final result = await ManageUser.getProfilByName(
            researchBarController.text,
          );
          setState(() {
            profils = result;
          });
        }
      },
      child: const Icon(Icons.search, color: secondaryBase, size: 32),
    );
  }

  Text textNumberUsersFound() {
    return Text(
      "${profils.length} profil${profils.length > 1 ? "s" : ""} trouvée",
      style: subSubTitle.copyWith(color: quinaryBase),
    );
  }

  ListView listUsers() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      children: [
        for (var profil in profils)
          userFound(
            "${profil["firstName"]} ${profil["lastName"]}",
            profil["id"],
            profil["avatar"],
            "${widget.currentUser[0]["firstName"]} ${widget.currentUser[0]["lastName"]}",
            widget.currentUser[0]["id"],
          ),
      ],
    );
  }

  Column userFound(
    String nameOfResearch,
    int idRecieve,
    String avatar,
    String nameCurrentUser,
    int idCurrentUser,
  ) {
    return Column(
      spacing: 18,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 24,
              children: [
                Avatar(picture: avatar, size: 37),
                Text(
                  TextServices.truncate(nameOfResearch, 19),
                  overflow: TextOverflow.ellipsis,
                  style: subSubTitle.copyWith(color: primaryBase),
                ),
              ],
            ),
            buttonAddUser(
              idRecieve,
              idCurrentUser,
              disabledButtons.contains(idRecieve),
              disableCallback: () {
                setState(() {
                  disabledButtons.add(idRecieve);
                });
              },
            ),
          ],
        ),
        SizedBox(child: Divider(thickness: 2, color: primaryBase)),
      ],
    );
  }

  ElevatedButton buttonAddUser(
    int idRecieve,
    int idCurrentUser,
    bool isDisabled, {
    required VoidCallback disableCallback,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        backgroundColor: primaryBase,
      ),

      onPressed: isDisabled
          ? null
          : () async {
              try {
                await FriendRelation.sendRequest(idRecieve, idCurrentUser);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Ami ajouter avec succès !"),
                    backgroundColor: primary200,
                  ),
                );
                disableCallback();
              } catch (e) {
                throw Exception("Erreur lors de l'ajout de l'ami: $e");
              }
            },
      child: const Icon(Icons.person_add_alt_1, color: secondaryBase, size: 24),
    );
  }
}
