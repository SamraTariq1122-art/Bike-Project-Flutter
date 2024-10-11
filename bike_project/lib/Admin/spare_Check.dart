import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpareListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpareView(),
    );
  }
}

class SpareView extends StatelessWidget {
    void _deleteRecord(String partId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Spare')
          .doc(partId)
          .delete();
    } catch (e) {
      print("Error deleting record: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Spare').snapshots(),
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

            final imageUrl = partData['imageUrl'];
            final itemName = partData['itemName'];
            final category = partData['category'];
            final price = partData['price'];
            final partId  = partData['partId'];

            return GestureDetector(
              onTap: () {
                _showImageDialog(context, imageUrl);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: ListTile(
                    leading: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey,
                          ),
                    title: Text(itemName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category: $category"),
                        Text("Price: $price"),
                      ],
                      
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                         _deleteRecord(partId);
                        // Handle cancel button click here
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
