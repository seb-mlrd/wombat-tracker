import 'package:flutter/material.dart';
import '../styles.dart';

final RegExp regex = RegExp(
  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
);

class InputForm extends StatefulWidget {
  final String typeInput;
  final TextEditingController nameController;

  const InputForm({
    super.key,
    required this.nameController,
    required this.typeInput,
  });

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final type = widget.typeInput;
    final isPassword =
        type == "Mot de passe" || type == "Confirmation du mot de passe";
    final isEmail = type == "Email";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 4),
      child: TextFormField(
        controller: widget.nameController,
        obscureText: isPassword ? !passwordVisible : false,
        validator: (value) {
          final isValid = RegExp(
            r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}',
          ).hasMatch(value!);
          if (value.isEmpty) {
            return 'Le champs ${widget.typeInput} est vide';
          } else if (isEmail && !regex.hasMatch(value)) {
            return 'Le champs ${widget.typeInput} n\'est pas un email valide';
          } else if (isPassword && !isValid) {
            return '8 caractères minimum et caractères spéciaux.';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          fillColor: primaryBase,
          filled: true,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: tertiary100,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )
              : null,
        ),
        style: const TextStyle(color: tertiary100),
      ),
    );
  }
}
