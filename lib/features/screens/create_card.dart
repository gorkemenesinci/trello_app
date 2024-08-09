import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trello_app/features/screens/card_detail_screen.dart';
import 'package:trello_app/features/widgets/card_container.dart';
import 'package:trello_app/features/widgets/card_textfield.dart';
import 'package:trello_app/models/colors.dart';
import 'package:trello_app/services/provider/dashboard_provider.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key, required this.onDashboardSelected});
  final Function(String) onDashboardSelected;

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  final AppColor appColor = AppColor();
  String _username = "";
  String selectedDashboardTitle = ""; // Seçilen pano başlığını saklamak için
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    name();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: appColor.homeBackground,
      appBar: AppBar(
        backgroundColor: appColor.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.close, color: appColor.loginText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();
                Provider.of<DashboardProvider>(context, listen: false)
                    .addListTile(title, description, selectedDashboardTitle);
                Navigator.of(context).pop();
              },
              child: Text(
                "Oluştur",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: appColor.loginText),
              )),
        ],
        title: const Text("Kart"),
        centerTitle: true,
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
                        onPressed: () async {
                          final selectedDashboard =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CardDetailScreen(),
                            ),
                          );

                          if (selectedDashboard != null &&
                              selectedDashboard is String) {
                            setState(() {
                              selectedDashboardTitle = selectedDashboard;
                            });
                            widget.onDashboardSelected(selectedDashboard);
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              selectedDashboardTitle.isNotEmpty
                                  ? selectedDashboardTitle
                                  : "Pano Seçin",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              "$_username çalışma alanı",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
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
                        child: Column(
                          children: [
                            Text(
                              "Deneme",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Container(
                color: appColor.backgroundColor,
                height: screenHeight * 0.07,
                child: CardTextfield(
                    maxLenght: 50,
                    controller: titleController,
                    hintText: "Bir ad eklemek için dokunun")),
            SizedBox(height: screenHeight * 0.002),
            Container(
                color: appColor.backgroundColor,
                height: screenHeight * 0.15,
                child: CardTextfield(
                    maxLenght: 200,
                    controller: descriptionController,
                    hintText: "Tarif eklemek için tıkla")),
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
                        child: Column(
                          children: [
                            Text(
                              "0",
                              style: Theme.of(context).textTheme.titleSmall,
                            )
                          ],
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
