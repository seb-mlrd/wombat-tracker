// lib/screen/content/edit_profil.dart

import 'package:flutter/material.dart';

// screen 
import 'package:wombat_tracker/main.dart';

// styles 
import 'package:wombat_tracker/styles.dart';

// utils 
import 'package:wombat_tracker/utils/manage_user.dart';
import 'package:wombat_tracker/utils/services/validators.dart';

// widget 
import 'package:wombat_tracker/widget/avatar.dart';
import 'package:wombat_tracker/widget/form/button_cta.dart';
import 'package:wombat_tracker/widget/form/input_form.dart';
import 'package:wombat_tracker/widget/form/label_form.dart';
import '../../widget/banner/wombat_banner_screen.dart';

class EditProfil extends StatefulWidget {
  final List<dynamic> profils;
  const EditProfil({super.key, required this.profils});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final _formKey = GlobalKey<FormState>();
  final nameEditController = TextEditingController();
  final lastNameEditController = TextEditingController();
  final phoneEditController = TextEditingController();
  final bioEditController = TextEditingController();
  final avatarEditController = TextEditingController();

  @override
  void dispose() {
    nameEditController.dispose();
    lastNameEditController.dispose();
    phoneEditController.dispose();
    bioEditController.dispose();
    avatarEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WombatBannerScreen(),
              SizedBox(height: 16),
              Avatar(picture: widget.profils[0]["avatar"], size: 50),

              Text("Modifier", style: subTitle.copyWith(color: quinaryBase)),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // input + label nom  
                    LabelForm(labelName: "Nom"),
                    InputForm(
                      key: Key("nameEditor"),
                      nameController: nameEditController,
                      typeInput: "edit-name",
                      methodeValidateInput: (value) =>
                          Validators.checkInputEmpty(
                            nameEditController.text,
                            "Nom",
                          ),
                      defaultValue: widget.profils[0]["firstName"],
                    ),
                    SizedBox(height: 32),

                    // input + label Prenom
                    LabelForm(labelName: "Prenom"),
                    InputForm(
                      key: Key("lastNameEditor"),
                      nameController: lastNameEditController,
                      typeInput: "edit-lastName",
                      methodeValidateInput: (value) =>
                          Validators.checkInputEmpty(
                            lastNameEditController.text,
                            "Prénom",
                          ),
                      defaultValue: widget.profils[0]["lastName"],
                    ),
                    SizedBox(height: 32),

                    // input + label Téléphone
                    LabelForm(labelName: "Téléphone"),
                    InputForm(
                      key: Key("phoneEditor"),
                      nameController: phoneEditController,
                      typeInput: "edit-phoone",
                      methodeValidateInput: (value) =>
                          Validators.validatePhone(phoneEditController.text),
                      defaultValue:
                          widget.profils[0]["phone"] == "'NULL'::character"
                          ? ""
                          : widget.profils[0]["phone"],
                    ),
                    SizedBox(height: 32),

                    // input + label Bio
                    LabelForm(labelName: "Bio"),
                    InputForm(
                      key: Key("bioEditor"),
                      nameController: bioEditController,
                      typeInput: "edit-bio",
                      methodeValidateInput: (value) =>
                          Validators.checkInputEmpty(
                            bioEditController.text,
                            "bio",
                          ),
                      defaultValue: widget.profils[0]["bio"] == "NULL"
                          ? ""
                          : widget.profils[0]["bio"],
                    ),

                    // input + label Avatar
                    LabelForm(labelName: "Lien Avatar"),
                    InputForm(
                      key: Key("avatarEditor"),
                      nameController: avatarEditController,
                      typeInput: "edit-avatar",
                      methodeValidateInput: (value) =>
                          Validators.checkInputEmpty(
                            avatarEditController.text,
                            "avatar",
                          ),
                      defaultValue: widget.profils[0]["avatar"] ?? "",
                    ),
                    // bouton submit
                    ButtonCta(
                      keyButton: "buttonEdit",
                      labelInput: "Enregistrer",
                      functionCallBack: () async {
                        ManageUser.editUser(
                          {
                            "firstName": nameEditController.text,
                            "lastName": lastNameEditController.text,
                            "phone": phoneEditController.text,
                            "bio": bioEditController.text,
                            "avatar": avatarEditController.text,
                          },
                          context,
                          _formKey,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MainApp();
                            },
                          ),
                        );
                      },
                      colorButton: primaryBase,
                      colorLabelbutton: secondaryBase,
                      buildContext: context,
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
}
