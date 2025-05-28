import 'package:flutter/material.dart';
import 'package:wombat_tracker/screen/auth/login.dart';
import 'package:wombat_tracker/styles.dart';

import '../../widget/label_form.dart';
import '../../widget/input_form.dart';
import '../../widget/wombat_banner.dart';
import '../../widget/redirect_link.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

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
                    nameController: emailController,
                    typeInput: "Email",
                  ),

                  LabelForm(labelName: "Nom"),
                  InputForm(nameController: nameController, typeInput: "Nom"),

                  LabelForm(labelName: "Prenom"),
                  InputForm(
                    nameController: lastNameController,
                    typeInput: "Prenom",
                  ),

                  LabelForm(labelName: "Mot de passe"),
                  InputForm(
                    nameController: passwordController,
                    typeInput: "Mot de passe",
                  ),

                  LabelForm(labelName: "Confirmation du mot de passe"),
                  InputForm(
                    nameController: confirmPasswordController,
                    typeInput: "Confirmation du mot de passe",
                  ),
                  buttonSignup(context),
                ],
              ),
            ),
            RedirectLink(text: "Crée-toi un compte", to: Login()),
          ],
        ),
      ),
    );
  }

  Container buttonSignup(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBase,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final confPassword = passwordController.text;
              final confEmail = emailController.text;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Envoi en cours !")));
              FocusScope.of(context).requestFocus(
                FocusNode(),
              ); // pour retirer le clavier au moment d'envoyer les informations
              print(confEmail);
              print(confPassword);
            }
          },
          child: Text(
            "Inscription",
            style: subSubTitle.copyWith(color: secondaryBase),
          ),
        ),
      ),
    );
  }
}
