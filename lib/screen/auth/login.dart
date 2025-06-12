// lib/screen/auth/login.dart

import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';

// utils 
import 'package:wombat_tracker/utils/auth_services.dart';
import 'package:wombat_tracker/utils/services/validators.dart';

// widget 
import 'package:wombat_tracker/widget/form/button_cta.dart';
import '../../widget/form/label_form.dart';
import '../../widget/form/input_form.dart';
import '../../widget/banner/wombat_banner.dart';

class Login extends StatefulWidget {
  final VoidCallback onSwitch;

  const Login({super.key, required this.onSwitch});

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
                    key: Key("inputEmail"),
                    nameController: emailController,
                    typeInput: "Email",
                    methodeValidateInput: (value) =>
                        Validators.validateEmail(emailController.text),
                  ),

                  LabelForm(labelName: "Mot de passe"),
                  InputForm(
                    key: Key("inputPassword"),
                    nameController: passwordController,
                    typeInput: "Mot de passe",
                    methodeValidateInput: (value) =>
                        Validators.validatePassword(passwordController.text),
                  ),
                  // buttonLogin(context),
                  ButtonCta(
                    keyButton: "loginButton",
                    labelInput: 'connexion',
                    functionCallBack: () async {
                      AuthServices.login(
                        {
                          "password": passwordController.text,
                          "email": emailController.text,
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
              child: const Text("Pas encore membre ? crée-toi un compte"),
            ),
          ],
        ),
      ),
    );
  }
}
