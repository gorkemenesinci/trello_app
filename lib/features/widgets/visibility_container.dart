import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trello_app/models/colors.dart';

class VisibilityContainer extends StatelessWidget {
  VisibilityContainer({super.key, required this.text, required this.text2});
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final AppColor appColor = AppColor();
  final Text text;
  final Text text2;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: screenHeight * 0.15,
      color: appColor.buttonBackground,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            text,
            text2,
          ],
        ),
      ),
    );
  }
}
