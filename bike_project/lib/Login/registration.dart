import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
// import 'package:flutter_signin_button/button_list.dart';
// import 'package:flutter_signin_button/button_view.dart';

class SignupPage extends StatefulWidget {
  // const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String password = '';
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final passwordController = TextEditingController();


  bool isPasswordVisible = false;
  void _showSuccessDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Registered Successfully'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 48,
              color: Colors.green,
            ),
            SizedBox(height: 8),
            Text('Congratulations! You have been registered successfully.'),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  )); // Correct navigation
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

   void _registerUser(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String name = nameController.text; // Get the user's name
    final String phone = phoneController.text; // Get the user's phone number

    // final String confirmPassword = confirmPasswordController.text;

    // Email validation: Check if the email ends with "@student.com"
    if (!email.endsWith('@gmail.com')) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
              'Please use a valid student email address ending with "@gmail.com".'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

   
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid) // Unique user ID as the document ID
          .set({
        'uid': userCredential.user!.uid, // Save the user's unique ID
        'name': name, // Store the user's name
        'phone': phone, // Store the user's phone number
        'email': email,
        
        // Add other user data fields if needed
      });
      _showSuccessDialogBox(context);
    } catch (e) {
      // Handle registration errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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
                        fit: BoxFit.cover),
                  ),
                  constraints:
                      const BoxConstraints.expand(height: 200, width: 180),
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
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.black,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(40),
                        gapPadding: 5),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    labelText: "UserName",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 10, top: 0),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.call),
                    prefixIconColor: Colors.black,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(40),
                        gapPadding: 5),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    labelText: "Phone-no",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 10, top: 0),
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
                  controller: passwordController,
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
                onPressed: ()  => _registerUser(context),
                // {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => Login()));
                // },
                child: Text("Sign-up"),
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
              // Text("Already have an Account? SignIn"),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Already have an Account? SignIn"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
