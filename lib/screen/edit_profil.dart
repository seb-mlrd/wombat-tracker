import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/manage_user.dart';
import 'package:wombat_tracker/utils/validators.dart';
import 'package:wombat_tracker/widget/Avatar.dart';
import 'package:wombat_tracker/widget/button_cta.dart';
import 'package:wombat_tracker/widget/input_form.dart';
import 'package:wombat_tracker/widget/label_form.dart';

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

  @override
  void dispose() {
    nameEditController.dispose();
    lastNameEditController.dispose();
    phoneEditController.dispose();
    bioEditController.dispose();
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
              Container(
                height: 154,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.only(top: 16, bottom: 16),
                decoration: BoxDecoration(color: primaryBase),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset("assets/img/component1banner.png"),
                    Image.asset("assets/img/component2banner.png"),
                  ],
                ),
              ),
              Avatar(picture: "assets/img/avatar.png"),

              Text("Modifier", style: subTitle.copyWith(color: quinaryBase)),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    LabelForm(labelName: "Téléphone"),
                    InputForm(
                      key: Key("phoneEditor"),
                      nameController: phoneEditController,
                      typeInput: "edit-phoone",
                      methodeValidateInput: (value) =>
                          Validators.validatePhone(phoneEditController.text),
                      defaultValue: widget.profils[0]["phone"] ?? "",
                    ),
                    SizedBox(height: 32),
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
                      defaultValue: widget.profils[0]["bio"] ?? "",
                    ),
                    ButtonCta(
                      keyButton: "buttonEdit",
                      labelInput: "Enregistrer",
                      functionCallBack: () async {
                        // print(widget.profils);
                        ManageUser.editUser(
                          {
                            "firstName": nameEditController.text,
                            "lastName": lastNameEditController.text,
                            "phone": phoneEditController.text,
                            "bio": bioEditController.text,
                          },
                          context,
                          _formKey,
                        );

                        Navigator.pop(context, true);
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
