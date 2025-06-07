import 'package:flutter/material.dart';

import 'package:wombat_tracker/styles.dart';
import 'package:wombat_tracker/utils/auth_services.dart';
import 'package:wombat_tracker/utils/validators.dart';
// import 'package:wombat_tracker/utils/manage_user.dart';
import 'package:wombat_tracker/widget/button_cta.dart';

import '../../widget/label_form.dart';
import '../../widget/input_form.dart';
import '../../widget/wombat_banner.dart';

class Signup extends StatefulWidget {
  final VoidCallback onSwitch;
  const Signup({super.key, required this.onSwitch});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  // controller qui va nous permettre de récupérer la valeur de notre input, pour chaque champs que l'on aura on devra créer un controller
  final passwordController = TextEditingController(); //controller pour le nom
  final emailController = TextEditingController(); //controller pour l'email
  final lastNameController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tertiary100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            WombatBanner(),
            Text("Inscription", style: title.copyWith(color: primaryBase)),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelForm(labelName: "Email"),
                  InputForm(
                    key: Key('inputEmail'),
                    nameController: emailController,
                    typeInput: "Email",
                    methodeValidateInput: (value) =>
                        Validators.validateEmail(emailController.text),
                  ),

                  LabelForm(labelName: "Nom"),
                  InputForm(
                    key: Key('inputName'),
                    nameController: nameController,
                    typeInput: "Nom",
                    methodeValidateInput: (value) =>
                        Validators.checkInputEmpty(emailController.text, "Nom"),
                  ),

                  LabelForm(labelName: "Prenom"),
                  InputForm(
                    key: Key('inputLastName'),
                    nameController: lastNameController,
                    typeInput: "Prenom",
                    methodeValidateInput: (value) => Validators.checkInputEmpty(
                      lastNameController.text,
                      "Prénom",
                    ),
                  ),

                  LabelForm(labelName: "Mot de passe"),
                  InputForm(
                    key: Key("inputPassword"),
                    nameController: passwordController,
                    typeInput: "Mot de passe",
                    methodeValidateInput: (value) =>
                        Validators.validatePassword(passwordController.text),
                  ),

                  LabelForm(labelName: "Confirmation du mot de passe"),
                  InputForm(
                    key: Key("inputConfirmPassword"),
                    nameController: confirmPasswordController,
                    typeInput: "Confirmation du mot de passe",
                    methodeValidateInput: (value) =>
                        Validators.validatePassword(
                          confirmPasswordController.text,
                        ),
                  ),
                  ButtonCta(
                    keyButton: "signUpButton",
                    labelInput: 'Inscription',
                    functionCallBack: () async {
                      AuthServices.signup(
                        {
                          "password": passwordController.text,
                          "email": emailController.text,
                          "lastName": lastNameController.text,
                          "name": nameController.text,
                          "confirmPassword": confirmPasswordController.text,
                        },
                        context,
                        _formKey,
                      );
                    },
                    colorButton: primaryBase,
                    colorLabelbutton: secondaryBase,
                    buildContext: context,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: widget.onSwitch,
              child: const Text("Déjà un compte ? connecte toi"),
            ),
          ],
        ),
      ),
    );
  }
}
