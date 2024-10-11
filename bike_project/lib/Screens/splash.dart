import 'package:flutter/material.dart';
import 'dart:async';

import '../Login/Login.dart';

// ignore: unused_import


class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/logo1.png"), fit: BoxFit.cover),
          ),
          constraints: const BoxConstraints.expand(height: 200, width: 200),
        ),
      ),
    );
  }
}
