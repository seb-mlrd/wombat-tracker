class Validators {
  static final RegExp regex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  static final isValidPassword = RegExp(
    r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}',
  );
  static String? validate(String? value, String type) {
    final isTypePassword =
        type == "Mot de passe" || type == "Confirmation du mot de passe";
    final isTypeEmail = type == "Email";

    if (value == null || value.isEmpty) {
      return 'Le champs $type est vide';
    } else if (isTypeEmail && !regex.hasMatch(value)) {
      return 'Le champs $type n\'est pas un email valide';
    } else if (isTypePassword && !isValidPassword.hasMatch(value)) {
      return '8 caractères minimum et caractères spéciaux.';
    }
    return null;
  }
}
