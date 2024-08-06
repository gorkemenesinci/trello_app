import 'package:flutter/material.dart';
import 'package:trello_app/features/screens/login_screen.dart';
import 'package:trello_app/features/screens/register_screen.dart';
import 'package:trello_app/features/widgets/outlined_button.dart';
import 'package:trello_app/models/colors.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  AppColor appColor = AppColor();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontal = screenWidth * 0.2;

    return Scaffold(
      backgroundColor: appColor.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth * 0.6,
            margin: EdgeInsets.symmetric(horizontal: horizontal),
            child: Image.asset("assets/images/trello_text.png"),
          ),
          Container(
            width: screenWidth * 0.7,
            margin: EdgeInsets.symmetric(horizontal: horizontal / 2),
            // AnimationController ile dönme animasyonu
            child: Image.asset("assets/images/trello_login.png"),
          ),
          Text(
            textAlign: TextAlign.center,
            "Hareket halindeyken dahi takım çalışmasını ileriye taşıyın",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold, color: appColor.loginText),
          ),
          SizedBox(
            height: screenHeight * 0.06,
          ),
          Column(
            children: [
              AppOutlinedButton(
                  onPress: () {
                    Navigator.push(context, _createRoute(const LoginScreen()));
                  },
                  text: const Text("Giriş Yap"),
                  backgroundColor: appColor.buttonBackground,
                  foregroundColor: appColor.buttonForeground),
              SizedBox(height: screenHeight * 0.01),
              AppOutlinedButton(
                  onPress: () {
                    Navigator.push(
                        context, _createRoute(const RegisterScreen()));
                  },
                  text: const Text("Kayıt Ol"),
                  backgroundColor: appColor.backgroundColor,
                  foregroundColor: appColor.buttonForeground),
            ],
          ),
        ],
      ),
    );
  }
}

Route _createRoute(Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(8, 5);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      reverseTransitionDuration: const Duration(milliseconds: 800),
      transitionDuration: const Duration(milliseconds: 600));
}
