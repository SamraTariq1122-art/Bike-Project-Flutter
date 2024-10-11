import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Check Uploaded/Users_Check.dart';
import 'Upload_Admin.dart';
import 'admin_Log.dart';
import 'checkPage.dart';
import 'const.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // Create the provided gradient
  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [g1, g2],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADMIN PANEL",style: TextStyle(color: Colors.black),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Admin_Login()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "WELCOME ADMIN TO MANGEMENT",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 107, 105, 105)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Upload_Admin(),
                        ));
                  },
                  child: buildCard(Icons.cloud_upload_rounded, "Upload Data"),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminCheck(),
                          ));
                    },
                    child: buildCard(
                        Icons.domain_verification_outlined, "Show Uploaded")),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UsersListPage(),
                          ));
                    },
                    child: buildCard(
                        Icons.question_mark_rounded, "Check Users")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(IconData icon, String title) {
    double cardWidth = MediaQuery.of(context).size.width * 0.7;
    double cardHeight = MediaQuery.of(context).size.height * 0.4;

    return Container(
      margin: EdgeInsets.all(10),
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Color.fromARGB(255, 87, 85, 86)),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
