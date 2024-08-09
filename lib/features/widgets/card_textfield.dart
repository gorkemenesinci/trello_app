import 'package:flutter/material.dart';

class CardTextfield extends StatelessWidget {
  const CardTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.maxLenght});
  final TextEditingController controller;
  final String hintText;
  final int maxLenght;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        controller: controller,
        maxLines: 5,
        maxLength: maxLenght,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
