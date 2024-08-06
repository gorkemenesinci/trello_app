import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trello_app/features/widgets/visibility_container.dart';
import 'package:trello_app/models/colors.dart';

class VisibilityScreen extends StatefulWidget {
  const VisibilityScreen({super.key});

  @override
  State<VisibilityScreen> createState() => _VisibilityScreenState();
}

class _VisibilityScreenState extends State<VisibilityScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String _username = "";
  @override
  void initState() {
    name();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    AppColor appColor = AppColor();
    return Scaffold(
      backgroundColor: appColor.homeBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColor.buttonForeground),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          color: appColor.backgroundColor,
        ),
        title: Text(
          "Görünürlük",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: appColor.buttonForeground),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            Container(
              width: double.infinity,
              height: screenHeight * 0.15,
              color: Colors.white,
              child: Column(
                children: [
                  VisibilityContainer(
                      text: Text(
                        "Gizli",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                      text2: Text(
                        "Yönetim kurulu üyeleri ve $_username çalışma alanı çalışma alanı  yöneticileri bu panoyu görebilir ve düzenleyebilir.",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Container(
              width: double.infinity,
              height: screenHeight * 0.15,
              color: Colors.white,
              child: Column(
                children: [
                  VisibilityContainer(
                      text: Text(
                        "Çalışma Alanı",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                      text2: Text(
                        "$_username çalışma alanı çalışma alanındaki herkes bu panoyu görebilir.",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ))
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Container(
              width: double.infinity,
              height: screenHeight * 0.15,
              color: Colors.white,
              child: Column(
                children: [
                  VisibilityContainer(
                    text: Text(
                      "Herkese Açık",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                    text2: Text(
                      "Bu pano herkese açık. Bağlantı linkine sahip herkes  tarafından görüntülenebilir ve Google gibi arama motorlarında görünecektir. Ancak sadece panoya davet edilenler düzenleme yapma yetkisine sahiptir",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> name() async {
    final auth = firebaseAuth.currentUser!.uid;
    final username =
        await FirebaseFirestore.instance.collection('users').doc(auth).get();
    final data = username.data() as Map<String, dynamic>;
    setState(() {
      _username = data['username'] ?? "No Username";
    });
  }
}
