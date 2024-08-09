import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trello_app/features/screens/visibility_screen.dart';
import 'package:trello_app/features/widgets/dashboard_container.dart';
import 'package:trello_app/models/colors.dart';
import 'package:trello_app/services/provider/dashboard_provider.dart';

class CreateDashboard extends StatefulWidget {
  const CreateDashboard({super.key});

  @override
  State<CreateDashboard> createState() => _CreateDashboardState();
}

class _CreateDashboardState extends State<CreateDashboard> {
  AppColor appColor = AppColor();
  String _username = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();
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
                final dashboardTitle = controller.text.trim();
                final dashboradVisibility =
                    Provider.of<DashboardProvider>(context, listen: false)
                        .visibility;
                Provider.of<DashboardProvider>(context, listen: false)
                    .addList(dashboardTitle, dashboradVisibility);
                Navigator.of(context).pop();
              },
              child: Text(
                "OLUŞTUR",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: appColor.loginText),
              )),
        ],
        title: const Text("Pano"),
        centerTitle: true, // Resmi ortalamak için
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Yeni Pano",
                  hintTextDirection: TextDirection.ltr,
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: appColor.textfieldHintText,
                      ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: appColor.buttonBackground),
                      gapPadding: 8,
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: screenHeight * 0.06),
            DashboardContainer(
              text: Text(
                "Çalışma Alanları",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              textButton: TextButton(
                onPressed: () {},
                child: Text(
                  "$_username Çalışma Alanı",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            DashboardContainer(
              text: Text(
                "Görünürlük",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              textButton: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VisibilityScreen(
                            onVisibilitySelected: (String visibility) {
                              Provider.of<DashboardProvider>(context,
                                      listen: false)
                                  .setVisibility(visibility);
                            },
                          ),
                        ));
                  },
                  child: Text(
                    Provider.of<DashboardProvider>(context).visibility,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ),
            SizedBox(height: screenHeight * 0.01),
            DashboardContainer(
              text: Text(
                "Arkaplan",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              textButton: TextButton(
                  onPressed: () {},
                  child: Container(
                    width: 30,
                    height: 30,
                    color: appColor.buttonBackground,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> name() async {
    final auth = firebaseAuth.currentUser!.uid;
    final username =
        await FirebaseFirestore.instance.collection("users").doc(auth).get();
    final data = username.data() as Map<String, dynamic>;
    setState(() {
      _username = data['username'] ?? "No Username";
    });
  }
}
