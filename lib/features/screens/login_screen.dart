import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trello_app/features/screens/home_screen.dart';
import 'package:trello_app/features/screens/register_screen.dart';
import 'package:trello_app/features/widgets/login_textfield.dart';
import 'package:trello_app/features/widgets/outlined_button.dart';
import 'package:trello_app/models/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AppColor appColor = AppColor();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontal = screenWidth * 0.2;
    return Scaffold(
      backgroundColor: appColor.buttonBackground,
      appBar: AppBar(
        flexibleSpace: Container(
          color: appColor.buttonBackground,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.7,
                margin: EdgeInsets.symmetric(horizontal: horizontal / 2),
                child: Image.asset("assets/images/trello_login.png"),
              ),
              LoginTextfield(
                loginController: controller1,
                keyboardType: TextInputType.emailAddress,
                hintText: "E-Mail : ",
              ),
              LoginTextfield(
                loginController: controller2,
                hintText: "Şifre :",
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: screenWidth * 0.1),
              AppOutlinedButton(
                onPress: _login,
                text: const Text("Giriş Yap"),
                backgroundColor: appColor.backgroundColor,
                foregroundColor: appColor.buttonForeground,
              ),
              SizedBox(height: screenWidth * 0.1),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ));
                },
                child: Text(
                  "Hesabınız Yok Mu? ",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: appColor.buttonForeground,
                        decoration: TextDecoration.underline, // Alt çizgi
                        decorationThickness: 2, // Alt çizginin kalınlığı
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: controller1.text.trim(),
        password: controller2.text.trim(),
      );
      print("Giriş başarılı: ${userCredential.user?.email}");

      // Giriş başarılı olduğunda yönlendirme
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Giriş hatası: ${e.message}")),
      );
    }
  }
}
