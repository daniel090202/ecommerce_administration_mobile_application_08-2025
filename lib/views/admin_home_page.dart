import 'package:ecommerce_admin/controllers/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_admin/containers/home_button.dart';
import 'package:ecommerce_admin/containers/dashboard_text.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().logOut();

              Navigator.pushNamedAndRemoveUntil(
                context,
                "/login",
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 235.0,
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardText(keyword: "Total Products", value: "100"),
                  DashboardText(keyword: "Total Products", value: "100"),
                  DashboardText(keyword: "Total Products", value: "100"),
                  DashboardText(keyword: "Total Products", value: "100"),
                ],
              ),
            ),

            Row(
              children: [
                HomeButton(name: "Orders", onTap: () {}),
                HomeButton(name: "Products", onTap: () {}),
              ],
            ),

            Row(
              children: [
                HomeButton(name: "Promos", onTap: () {}),
                HomeButton(name: "Banners", onTap: () {}),
              ],
            ),

            Row(
              children: [
                HomeButton(name: "Categories", onTap: () {}),
                HomeButton(name: "Coupons", onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
