import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wombat_tracker/screen/auth/login.dart';
import 'package:wombat_tracker/screen/auth/signup.dart';

void main() {
  group("Champ vide", () {
    testWidgets("input email formulaire longin", (WidgetTester tester) async {
      final inputEmail = find.byKey(ValueKey("inputEmail"));
      final loginButton = find.byKey(ValueKey("loginButton"));

      await tester.pumpWidget(MaterialApp(home: Login(onSwitch: () {})));
      await tester.enterText(inputEmail, "");
      await tester.tap(loginButton);

      await tester.pump();

      expect(find.text("Le champs Email est vide"), findsOneWidget);
    });
    testWidgets("input password formulaire longin", (
      WidgetTester tester,
    ) async {
      final inputPassword = find.byKey(ValueKey("inputPassword"));
      final loginButton = find.byKey(ValueKey("loginButton"));

      await tester.pumpWidget(MaterialApp(home: Login(onSwitch: () {})));
      await tester.enterText(inputPassword, "");
      await tester.tap(loginButton);

      await tester.pump();

      expect(find.text("Le champs Mot de passe est vide"), findsOneWidget);
    });
  });
  group("Voir / cacher le mot de passe", () {
    testWidgets("Voir le mot de passe", (WidgetTester tester) async {
      final inputPassword = find.byKey(ValueKey("inputPassword"));
      final iconEye = find.byKey(ValueKey("iconEye"));

      await tester.pumpWidget(MaterialApp(home: Login(onSwitch: () {})));
      await tester.enterText(inputPassword, "mot de passs ici");
      await tester.tap(iconEye);

      await tester.pump();

      final iconWidget = tester.widget<Icon>(find.byKey(ValueKey("iconEye")));
      expect(iconWidget.icon, equals(Icons.visibility));
    });
    testWidgets("Cacher le mot de passe", (WidgetTester tester) async {
      final inputPassword = find.byKey(ValueKey("inputPassword"));

      await tester.pumpWidget(MaterialApp(home: Login(onSwitch: () {})));
      await tester.enterText(inputPassword, "mot de passs ici");

      await tester.pump();

      final iconWidget = tester.widget<Icon>(find.byKey(ValueKey("iconEye")));
      expect(iconWidget.icon, equals(Icons.visibility_off));
    });

    group("Comparaison mot de passe", () {
      testWidgets("Mot de passe différent", (WidgetTester tester) async {
        final inputPassword = find.byKey(ValueKey("inputPassword"));
        final inputConfirmPassword = find.byKey(
          ValueKey('inputConfirmPassword'),
        );
        final inputEmail = find.byKey(ValueKey("inputEmail"));
        final inputName = find.byKey(ValueKey("inputName"));
        final inputLastName = find.byKey(ValueKey("inputLastName"));
        final signupButton = find.byKey(ValueKey("signUpButton"));

        await tester.pumpWidget(MaterialApp(home: Signup(onSwitch: () {})));

        await tester.enterText(inputEmail, "test@test.fr");
        await tester.enterText(inputName, "Jean");
        await tester.enterText(inputLastName, "Naymar");
        await tester.enterText(inputPassword, "l3MotDep@sseDuSiècle");
        await tester.enterText(inputConfirmPassword, "mdpNull123@");

        await tester.ensureVisible(
          signupButton,
        ); // faire scroller jusqu'au button s'inscrir
        await tester.tap(signupButton);

        await tester.pump();

        expect(
          find.text("Les mots de passe ne correspondent pas."),
          findsOneWidget,
        );
      });
    });
  });
}
