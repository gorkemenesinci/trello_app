import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton(
      {super.key,
      required this.onPress,
      required this.text,
      required this.backgroundColor,
      required this.foregroundColor});

  final void Function() onPress;
  final Text text;
  final Color foregroundColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: const BorderSide(width: 1, color: Colors.black),
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor),
        onPressed: onPress,
        child: text,
      ),
    );
  }
}
