import 'package:bike_project/Login/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Admin/admin_Log.dart';
import '../Screens/dashbord_screen.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // const Login({Key? key}) : super(key: key);
  String password = '';
  TextEditingController emailController = TextEditingController();

  bool isPasswordVisible = false;
  bool validateInputs() {
    // Check if email and password fields are not empty
    if (emailController.text.isEmpty || password.isEmpty) {
      return false;
    }
    // Add more validation checks if needed
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo1.png'),
                      ),
                      color: Colors.white),
                  constraints: BoxConstraints.expand(height: 190, width: 170),
                ),
              ),
              Text(
                "Fix Bikes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 10, top: 25),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Colors.black,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(40),
                        gapPadding: 5),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    labelText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 0, right: 30, bottom: 0),
                child: TextField(
                  onChanged: (value) => setState(() {
                    this.password = value;
                  }),
                  onSubmitted: (value) => setState(() {
                    this.password = value;
                  }),
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: IconButton(
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(40)
                      gapPadding: 5,
                    ),
                    labelText: "Password",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (validateInputs()) {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // Prevent closing the dialog by tapping outside
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: password,
                      );

                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection("Users")
                          .doc(userCredential.user?.uid)
                          .get();

                      Navigator.pop(
                          context); // Close the loading indicator dialog

                      if (userDoc.exists) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Logged in successfully!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen()));
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User not found')));
                      }
                    } catch (e) {
                      Navigator.pop(
                          context); // Close the loading indicator dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $e')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')));
                  }
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  fixedSize: Size(300, 50),
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  primary: Colors.blue[100],
                  onPrimary: Colors.black,
                  elevation: 18,
                  shadowColor: Colors.black,
                  side: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              // Text("Don't have an Account? Sign-up"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text("Don't have an Account? Sign-up"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Admin_Login(),
                      ));
                },
                child: Text("Admin Login"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.black),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                child: Column(
                  children: [
                    Text("Or Sign-in with "),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SignInButton(
                          Buttons.Facebook,
                          mini: true,
                          onPressed: () {},
                        ),
                        SignInButton(
                          Buttons.LinkedIn,
                          mini: true,
                          onPressed: () {},
                        ),
                        SignInButton(
                          Buttons.Hotmail,
                          mini: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
