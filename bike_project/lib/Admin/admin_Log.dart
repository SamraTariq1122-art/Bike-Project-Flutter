import 'package:bike_project/Login/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'AdminHome.dart';
import 'const.dart';

class Admin_Login extends StatefulWidget {
  const Admin_Login({super.key});

  @override
  State<Admin_Login> createState() => _Admin_LoginState();
}

class _Admin_LoginState extends State<Admin_Login> {
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle,
                color: Color.fromARGB(255, 79, 70, 77), size: 58),
            SizedBox(height: 16),
            Text('ADMIN LOGGED IN !!!'),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.of(context).pop(); // Close the success dialog
            //     Navigator.pushReplacement(
            //       // Navigate to AdminHome
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => AdminHome(),
            //       ),
            //     );
            //   },
            //   child: Text('OK'),
            //   style: ElevatedButton.styleFrom(
            //     primary:Color.fromARGB(255, 228, 110, 214),
            //     padding: EdgeInsets.symmetric(horizontal: 24),
            //   ),
            // ),
            // SizedBox(height: 5)
          ],
        ),
      ),
    );
  }

  bool _ObSecure = false;

  void _loginUser(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    // Check if email and password are empty
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.clear, color: Colors.red, size: 58),
              SizedBox(height: 16),
              Text('Email and password cannot be empty!'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
              SizedBox(height: 5)
            ],
          ),
        ),
      );
    } else if (email == 'admin@admin.com' && password == 'admin123@') {
      // Show success dialog
      _showSuccessDialog(context);

      try {
        await Future.delayed(Duration(seconds: 2));
      } catch (e) {
        // Handle login error if needed
      }

      // Login success, navigate to AdminHome
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHome(),
        ),
      );
    } else {
      // Show error dialog for invalid credentials
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.clear, color: Colors.red, size: 58),
              SizedBox(height: 16),
              Text('Only Admin Can Login!!!'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                ),
              ),
              SizedBox(height: 5)
            ],
          ),
        ),
      );
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [g1, g2],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.030),
            child: OverflowBar(
              overflowAlignment: OverflowBarAlignment.center,
              overflowSpacing: size.height * 0.014,
              children: [
                Image.asset(admin),
                Text(
                  "Welcome Admin!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  "To Management Portal",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.024),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: kInputColor),
                  decoration: InputDecoration(

                    contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                    filled: true,
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.black,
                    fillColor: kWhiteColor,
                    border: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(37),
                    ),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: _ObSecure,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: kInputColor),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                    filled: true,
                    hintText: "Password",
                    suffixIcon: IconButton(
                        icon: Icon(_ObSecure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _ObSecure = !_ObSecure;
                          });
                        }),
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: Colors.black,
                    fillColor: kWhiteColor,
                    border: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(37),
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: size.height * 0.080,
                    decoration: BoxDecoration(
                      color: kButtonColor,
                      borderRadius: BorderRadius.circular(37),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () => _loginUser(context),
                ),
                SizedBox(height: size.height * 0.014),
                SvgPicture.asset("assets/icons/deisgn.svg"),
                SizedBox(height: size.height * 0.014),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: size.height * 0.080,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 45,
                          spreadRadius: 0,
                          color: Color.fromRGBO(120, 37, 139, 0.25),
                          offset: Offset(0, 25),
                        )
                      ],
                      borderRadius: BorderRadius.circular(37),
                      color: const Color.fromRGBO(225, 225, 225, 0.28),
                    ),
                    child: const Text(
                      "Go Back?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
