import 'package:flutter/material.dart';
import 'package:trello_app/models/colors.dart';

class CardContainer extends StatelessWidget {
  CardContainer({super.key, required this.height, required this.child});
  final double height;
  final Widget child;
  final AppColor appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColor.loginText,
      width: double.infinity,
      alignment: Alignment.center,
      height: height,
      child: child,
    );
  }
}
