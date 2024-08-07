import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trello_app/features/widgets/card_container.dart';
import 'package:trello_app/features/widgets/card_textfield.dart';
import 'package:trello_app/models/colors.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  final AppColor appColor = AppColor();
  String _username = "";
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    name();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: appColor.buttonForeground,
      appBar: AppBar(
        backgroundColor: appColor.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.close, color: appColor.loginText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Oluştur",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: appColor.loginText),
              )),
        ],
        title: const Text("Kart"),
        centerTitle: true, // Resmi ortalamak için
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.015),
            CardContainer(
              height: screenHeight * 0.08,
              child: ListTile(
                title: const Text("Pano"),
                leading: const Icon(Icons.dashboard),
                trailing: Column(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            const Text("Deneme"),
                            Text("$_username çalışma alanı"),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            CardContainer(
              height: screenHeight * 0.06,
              child: ListTile(
                title: const Text("Liste"),
                leading: const Icon(Icons.list),
                trailing: Column(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Column(
                          children: [
                            Text("Deneme"),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Container(
                color: Colors.white,
                height: screenHeight * 0.07,
                child: const CardTextfield(
                    hintText: "Bir ad eklemek için dokunun")),
            SizedBox(height: screenHeight * 0.002),
            Container(
                color: Colors.white,
                height: screenHeight * 0.15,
                child:
                    const CardTextfield(hintText: "Tarif eklemek için tıkla")),
            SizedBox(height: screenHeight * 0.015),
            CardContainer(
              height: screenHeight * 0.05,
              child: const ListTile(
                title: Text("Başlangıç tarihi.."),
                leading: Icon(Icons.timer),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            CardContainer(
              height: screenHeight * 0.05,
              child: const ListTile(
                title: Text("Bitiş Tarihi.."),
                leading: Icon(Icons.timer),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            CardContainer(
              height: screenHeight * 0.05,
              child: const ListTile(
                title: Text("Üyeler.."),
                leading: Icon(Icons.person_2_outlined),
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            CardContainer(
              height: screenHeight * 0.06,
              child: ListTile(
                title: const Text("Eklentiler"),
                leading: const Icon(Icons.attach_file_outlined),
                trailing: Column(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Column(
                          children: [Text("0")],
                        ))
                  ],
                ),
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
      _username = data['username'] ?? "No Profile Name";
    });
  }
}
