import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trello_app/features/screens/create_card.dart';
import 'package:trello_app/features/screens/create_dashboard.dart';
import 'package:trello_app/features/screens/card_detail_screen.dart';
import 'package:trello_app/features/screens/dashboard_detail_screen.dart';
import 'package:trello_app/models/colors.dart';
import 'package:trello_app/services/provider/dashboard_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppColor appColor = AppColor();
  TextEditingController controller = TextEditingController();
  String _username = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    name();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontal = screenWidth * 0.03;
    final listDashboard = Provider.of<DashboardProvider>(context);
    final dashboards = listDashboard.list;

    return Scaffold(
      backgroundColor: appColor.homeBackground,
      appBar: AppBar(
        backgroundColor: appColor.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColor.loginText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset(
          "assets/images/trello_text.png",
          height: screenHeight * 0.1, // Yüksekliği artırarak resmi büyütüyoruz
        ),
        centerTitle: true, // Resmi ortalamak için
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.add,
              size: screenHeight * 0.039,
              color: appColor.loginText,
            ),
            onSelected: (value) {
              if (value.characters.first == 'P') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateDashboard()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateCard(
                              onDashboardSelected: (String select) {
                                Provider.of<DashboardProvider>(context,
                                        listen: false)
                                    .setSelect(select);
                              },
                            )));
              }
            },
            itemBuilder: (BuildContext context) {
              return <String>['Pano Oluştur', 'Bir Kart Yarat']
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            SizedBox(height: screenHeight * 0.02),
            SizedBox(height: screenHeight * 0.02),
            Text(
              textAlign: TextAlign.start,
              "ÇALIŞMA ALANLARINIZ",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: appColor.loginText),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              height: screenHeight * 0.04,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontal),
                child: Row(
                  children: [
                    Text(
                      "$_username çalışma alanı",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: appColor.loginText),
                    ),
                    const Spacer(),
                    TextButton.icon(
                        iconAlignment: IconAlignment.end,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: appColor.buttonForeground,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CardDetailScreen(),
                          ));
                        },
                        label: Text(
                          "Panolar",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: appColor.buttonForeground),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Container(
              decoration: BoxDecoration(
                  color: appColor.homeBackground,
                  borderRadius: BorderRadius.circular(10)),
              width: screenWidth,
              height: screenHeight,
              child: ListView.builder(
                itemCount: dashboards.length,
                itemBuilder: (context, index) {
                  final dashboard = dashboards[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DashboardDetailScreen(),
                      ));
                    },
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    leading: Container(
                      width: 30,
                      height: 30,
                      color: appColor.buttonBackground,
                    ),
                    title: Text(
                      dashboard['title'] ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      dashboard['visibility'] ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: appColor.textfieldHintText),
                    ),
                  );
                },
              ),
            )
          ]),
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
