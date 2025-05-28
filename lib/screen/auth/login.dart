import 'package:flutter/material.dart';
import 'package:wombat_tracker/screen/auth/signup.dart';
import 'package:wombat_tracker/styles.dart';

import '../../widget/label_form.dart';
import '../../widget/input_form.dart';
import '../../widget/wombat_banner.dart';
import '../../widget/redirect_link.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  // controller qui va nous permettre de récupérer la valeur de notre input, pour chaque champs que l'on aura on devra créer un controller
  final passwordController = TextEditingController(); //controller pour le nom
  final emailController = TextEditingController(); //controller pour l'email

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
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
            Text("Connexion", style: title.copyWith(color: primaryBase)),

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

                  LabelForm(labelName: "Mot de passe"),
                  InputForm(
                    nameController: passwordController,
                    typeInput: "Mot de passe",
                  ),
                  buttonLogin(context),
                ],
              ),
            ),
            RedirectLink(text: "Pas encore membre ? crée-toi un compte  ", to: Signup()),
          ],
        ),
      ),
    );
  }

  Container buttonLogin(BuildContext context) {
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
            "Connexion",
            style: subSubTitle.copyWith(color: secondaryBase),
          ),
        ),
      ),
    );
  }
}
