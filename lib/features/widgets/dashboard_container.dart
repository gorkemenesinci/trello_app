import 'package:flutter/material.dart';
import 'package:trello_app/models/colors.dart';

class DashboardContainer extends StatelessWidget {
  const DashboardContainer(
      {super.key, required this.text, required this.textButton});
  final Text text;
  final TextButton textButton;

  @override
  Widget build(BuildContext context) {
    AppColor appColor = AppColor();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        color: appColor.backgroundColor,
        width: screenWidth,
        height: screenHeight * 0.07,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [text, const Spacer(), textButton],
          ),
        ));
  }
}
