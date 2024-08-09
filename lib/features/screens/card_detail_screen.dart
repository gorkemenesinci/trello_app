import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trello_app/models/colors.dart';
import 'package:trello_app/services/provider/dashboard_provider.dart';

class CardDetailScreen extends StatefulWidget {
  const CardDetailScreen({super.key});

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  final AppColor appColor = AppColor();
  String _username = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    name();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardsDetail = Provider.of<DashboardProvider>(context);
    final dashboards = dashboardsDetail.list;
    return Scaffold(
      backgroundColor: appColor.homeBackground,
      appBar: AppBar(
        backgroundColor: appColor.homeBackground,
        title: Text(
          "$_username Çalışma Alanı",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: dashboards.length,
        itemBuilder: (context, index) {
          final dashboard = dashboards[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).pop(dashboard['title']);
            },
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            leading: Container(
              width: 30,
              height: 30,
              color: appColor.buttonBackground,
            ),
            title: Text(
              dashboard['title'] ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: appColor.loginText),
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
