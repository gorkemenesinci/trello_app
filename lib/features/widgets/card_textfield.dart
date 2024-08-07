import 'package:flutter/material.dart';

class CardTextfield extends StatelessWidget {
  const CardTextfield({super.key, required this.hintText});

  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}
