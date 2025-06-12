class Validators {
  static final RegExp regexEmail = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  static final isValidPassword = RegExp(
    r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}',
  );
  static final regexPhone = RegExp(r'0(6|7)[0-9]{8}');
  static final regexInputTextEdit = RegExp(r'[A-Za-z]{3,50}');

  static String? checkInputEmpty(String? value, String nameInput) {
    if (value == null || value.isEmpty) {
      return 'Le champ $nameInput est vide';
    }
    return null;
  }

  static String? validatePassword(String value) {
    final error = checkInputEmpty(value, "Mot de passe");
    if (error != null) {
      return error;
    }
    if (!isValidPassword.hasMatch(value)) {
      return '8 caractères minimum et caractères spéciaux.';
    }
    return null;
  }

  static String? validateEmail(String value) {
    final error = checkInputEmpty(value, "Email");
    if (error != null) {
      return error;
    }
    if (!regexEmail.hasMatch(value)) {
      return 'L\'email n\'est pas un email valide';
    }
    return null;
  }

  static String? validatePhone(String value) {
    final error = checkInputEmpty(value, "Téléphone");
    if (error != null) {
      return error;
    }
    if (!regexPhone.hasMatch(value)) {
      return "Numéro dois être de type 06|7 XX XX XX XX XX";
    }
    return null;
  }
}
