import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trello_app/features/screens/select_screen.dart';
import 'package:trello_app/features/widgets/outlined_button.dart';
import 'package:trello_app/features/widgets/register_textfield.dart';
import 'package:trello_app/models/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AppColor appColor = AppColor();
  TextEditingController controller1 = TextEditingController(); // E-posta
  TextEditingController controller2 = TextEditingController(); // Şifre
  TextEditingController controller3 = TextEditingController(); // Kullanıcı Adı

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
              RegisterTextfield(
                controller: controller3,
                hintText: "Kullanıcı Adı : ",
                keyboardType: TextInputType.text,
              ),
              RegisterTextfield(
                controller: controller1,
                hintText: "E-Mail : ",
                keyboardType: TextInputType.emailAddress,
              ),
              RegisterTextfield(
                controller: controller2,
                hintText: "Şifre :",
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: screenWidth * 0.1),
              AppOutlinedButton(
                onPress: registerUser,
                text: const Text("Kayıt Ol"),
                backgroundColor: appColor.backgroundColor,
                foregroundColor: appColor.buttonForeground,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    try {
      // E-posta ve şifre formatlarını doğrula
      String email = controller1.text.trim();
      String password = controller2.text.trim();

      if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Geçersiz e-posta formatı!')),
        );
        return;
      }

      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Şifre en az 6 karakter olmalıdır!')),
        );
        return;
      }

      // Kullanıcı adı veya e-posta var mı kontrol et
      var usernameSnapshot = await firebaseFirestore
          .collection('users')
          .where('username', isEqualTo: controller3.text.trim())
          .get();

      var emailSnapshot = await firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (usernameSnapshot.docs.isNotEmpty || emailSnapshot.docs.isNotEmpty) {
        // Zaten kullanıcı varsa hata mesajı göster
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Bu kullanıcı adı veya e-posta zaten mevcut!')),
        );
      } else {
        // Kullanıcıyı Firebase Authentication ile oluştur
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Kullanıcı başarıyla oluşturuldu
        String userId = userCredential.user!.uid;

        // Firestore'a kullanıcı bilgilerini ekle
        await firebaseFirestore.collection('users').doc(userId).set({
          'username': controller3.text.trim(),
          'email': email,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kullanıcı başarıyla kaydedildi!')),
        );

        // Kullanıcıyı giriş yapmış olarak işaretle
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SelectScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Firebase Authentication hatası
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Kullanıcı kaydedilemedi: ${e.message ?? 'Bir hata oluştu!'}')),
      );
    } catch (e) {
      // Diğer hatalar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kullanıcı kaydedilemedi: $e')),
      );
    }
  }
}
