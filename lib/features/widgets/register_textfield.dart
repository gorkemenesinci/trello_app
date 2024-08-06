import 'package:flutter/material.dart';

class RegisterTextfield extends StatelessWidget {
  const RegisterTextfield(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.hintText});

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        controller: controller,
        keyboardType: keyboardType,
      ),
    );
  }
}
