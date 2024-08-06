import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  const LoginTextfield(
      {super.key,
      required this.loginController,
      required this.keyboardType,
      required this.hintText});

  final TextEditingController loginController;
  final TextInputType keyboardType;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: loginController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 4, color: Colors.black))),
      ),
    );
  }
}
