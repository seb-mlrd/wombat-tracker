import 'package:wombat_tracker/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('class Validators', () {
    group('Champs vide', () {
      test('Email vide', () {
        final result = Validators.validate('', 'Email');
        expect(result, 'Le champs Email est vide');
      });
      test('Nom vide', () {
        final result = Validators.validate('', 'Nom');
        expect(result, 'Le champs Nom est vide');
      });

      test('Prenom vide', () {
        final result = Validators.validate('', 'Prenom');
        expect(result, 'Le champs Prenom est vide');
      });

      test('Mot de passe vide', () {
        final result = Validators.validate('', 'Mot de passe');
        expect(result, 'Le champs Mot de passe est vide');
      });

      test('Confirmation du mot de passe vide', () {
        final result = Validators.validate('', 'Confirmation du mot de passe');
        expect(result, 'Le champs Confirmation du mot de passe est vide');
      });
    });

    group('Email invalide / valide', () {
      test('Email mal écrit', () {
        final result = Validators.validate('email@', 'Email');
        expect(result, 'Le champs Email n\'est pas un email valide');
      });

      test('Email valide', () {
        final result = Validators.validate('test@email.com', 'Email');
        expect(result, isNull);
      });
    });

    group('Mot de passe', () {
      test('Mot de passe non valide', () {
        final result = Validators.validate('abc', 'Mot de passe');
        expect(result, '8 caractères minimum et caractères spéciaux.');
      });

      test('Mot de passe valide', () {
        final result = Validators.validate('Strong@123', 'Mot de passe');
        expect(result, isNull);
      });
    });
  });
}
