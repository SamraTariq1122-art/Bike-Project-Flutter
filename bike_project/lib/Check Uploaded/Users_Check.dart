import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Admin/const.dart';

class UsersListPage extends StatelessWidget {
  
  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [g1, g2],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Users",
          style: TextStyle(color: Colors.black),
        ),
          flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
     
     ),
      body: UsersListView(),
    );
  }
}

class UsersListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final partsList = snapshot.data!.docs;

        return ListView.builder(
          itemCount: partsList.length,
          itemBuilder: (context, index) {
            final part = partsList[index];
            final partData = part.data() as Map<String, dynamic>;

            // final imageUrl = partData['imageUrl'];
            final name = partData['name'];
            final email = partData['email'];
            final phone = partData['phone'];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: ListTile(
                  title: Text(name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email: $email"),
                      Text("Phone No: $phone"),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
