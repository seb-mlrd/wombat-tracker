import 'package:wombat_tracker/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('class Validators', () {
    group('Champs vide', () {
      test('Email vide', () {
        final result = Validators.validateEmail('');
        expect(result, 'Le champ Email est vide');
      });
      test('Nom vide', () {
        final result = Validators.checkInputEmpty('', 'Nom');
        expect(result, 'Le champ Nom est vide');
      });

      test('Prenom vide', () {
        final result = Validators.checkInputEmpty('', 'Prenom');
        expect(result, 'Le champ Prenom est vide');
      });

      test('Mot de passe vide', () {
        final result = Validators.validatePassword('');
        expect(result, 'Le champ Mot de passe est vide');
      });

      test('Champ Téléphone vide', () {
        final result = Validators.validatePhone('');
        expect(result, 'Le champ Téléphone est vide');
      });
    });

    group('Email invalide / valide', () {
      test('Email mal écrit', () {
        final result = Validators.validateEmail('email@');
        expect(result, 'L\'email n\'est pas un email valide');
      });

      test('Email valide', () {
        final result = Validators.validateEmail('test@email.com');
        expect(result, isNull);
      });
    });

    group('Mot de passe', () {
      test('Mot de passe non valide', () {
        final result = Validators.validatePassword('abc');
        expect(result, '8 caractères minimum et caractères spéciaux.');
      });

      test('Mot de passe valide', () {
        final result = Validators.validatePassword('Strong@123');
        expect(result, isNull);
      });
    });
    group("Téléphone valide / invalide", () {
      test('Téléphone valide', () {
        final result = Validators.validatePhone('0618994630');
        expect(result, isNull);
      });
      test('Téléphone invalide', () {
        final result = Validators.validatePhone('06189630');
        expect(result, "Numéro dois être de type 06|7 XX XX XX XX XX");
      });
    });
  });
}
