import 'package:flutter/material.dart';
import 'package:wombat_tracker/styles.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:wombat_tracker/main.dart';

import '../../widget/label_form.dart';
import '../../widget/input_form.dart';
import '../../widget/wombat_banner.dart';

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
                  ),

                  LabelForm(labelName: "Mot de passe"),
                  InputForm(
                    key: Key("inputPassword"),
                    nameController: passwordController,
                    typeInput: "Mot de passe",
                  ),
                  buttonLogin(context),
                ],
              ),
            ),
            // RedirectLink(
            //   text: "Pas encore membre ? crée-toi un compte",
            //   to: Signup(),
            // ),
            TextButton(
              onPressed: widget.onSwitch,
              child: const Text("Pas encore membre ? crée-toi un compte"),
            ),
          ],
        ),
      ),
    );
  }

  Container buttonLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      key: Key("loginButton"),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBase,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final confPassword = passwordController.text;
              final confEmail = emailController.text;

              FocusScope.of(context).requestFocus(
                FocusNode(),
              ); // pour retirer le clavier au moment d'envoyer les informations

              try {
                // utilisation de supabase pour l'inscription
                // final AuthResponse res = await supabase.auth.signInWithPassword(
                await supabase.auth.signInWithPassword(
                  email: confEmail,
                  password: confPassword,
                  // enregistrement des informations de l'utilisateur dans la table Profil
                );

                // final Session? session = res.session;
                // final User? user = res.user;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Connexion réussie."),
                    backgroundColor: primary200,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
              }
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
