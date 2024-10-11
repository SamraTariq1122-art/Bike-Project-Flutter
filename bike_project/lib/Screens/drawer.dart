import 'package:flutter/material.dart';

import '../Login/Login.dart';

// import 'package:project/Classes/AddProperty.dart';
// import 'package:project/Classes/ContactUs.dart';
// import 'package:project/Classes/Login.dart';

class ddrawer extends StatelessWidget {
  const ddrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            // color: Theme.of(context).primaryColor,
            color: Colors.black12,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  // height: 130,
                  // width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/logo1.png'),
                      // fit: BoxFit.fill
                    ),
                  ),
                  constraints: const BoxConstraints.expand(
                      width: 180,
                      height: 140

                  ),
                ),
                Text(
                  "Fix Bike",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  "(Selling, Consulting, Renting)",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(
              "Contact Us",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactUs()));
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Add Property",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProperty()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.messenger),
          //   title: Text(
          //     "Messenger",
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   onTap: () {
          //     // FlutterPhoneDirectCaller.callNumber
          //   },
          // ),
        ],
      ),
    );
  }
}
