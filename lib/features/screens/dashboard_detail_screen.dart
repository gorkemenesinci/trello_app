import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trello_app/models/colors.dart';
import 'package:trello_app/services/provider/dashboard_provider.dart';

class DashboardDetailScreen extends StatefulWidget {
  const DashboardDetailScreen({super.key});

  @override
  State<DashboardDetailScreen> createState() => _DashboardDetailScreenState();
}

class _DashboardDetailScreenState extends State<DashboardDetailScreen> {
  AppColor appColor = AppColor();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final dashboards = Provider.of<DashboardProvider>(context);
    final dashboard = dashboards.listTile;
    return Scaffold(
        backgroundColor: appColor.homeBackground,
        appBar: AppBar(
          flexibleSpace: Container(
            color: appColor.backgroundColor,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: appColor.homeBackground,
              borderRadius: BorderRadius.circular(10)),
          width: screenWidth,
          height: screenHeight,
          child: ListView.builder(
            itemCount: dashboard.length,
            itemBuilder: (context, index) {
              final dashboardDetail = dashboard[index];
              return ListTile(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                title: Row(
                  children: [
                    Text(
                      dashboardDetail['title'] ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Spacer(),
                    Text(
                      dashboardDetail['dashboard'] ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                subtitle: Text(dashboardDetail['description'] ?? ""),
              );
            },
          ),
        ));
  }
}
