import 'package:flutter/material.dart';
import 'package:wombat_tracker/utils/validators.dart';
import '../styles.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 4),
      child: TextFormField(
        controller: widget.nameController,
        obscureText: isPassword ? !passwordVisible : false,
        validator: (value) => Validators.validate(value, type),
        decoration: eyeDecoration(isPassword),
        style: const TextStyle(color: tertiary100),
      ),
    );
  }

  InputDecoration eyeDecoration(bool isPassword) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      fillColor: primaryBase,
      filled: true,
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                key: Key("iconEye"),
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
    );
  }
}
