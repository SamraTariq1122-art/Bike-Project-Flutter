import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Add this import for Firebase Storage
import 'package:image_picker/image_picker.dart'; // Add this import for image picker
import 'dart:io'; // Add this import for File

import '../Admin/Upload_Admin.dart';

class Bike_Upload extends StatefulWidget {
  const Bike_Upload({super.key});

  @override
  State<Bike_Upload> createState() => _Bike_UploadState();
}

class _Bike_UploadState extends State<Bike_Upload> {
    String itemPrice = "";
  String _selectedCategory = "Honda";
  // String _selectedSection = "Brand-New";
  // DateTime _selectedDateTime = DateTime.now();
  String itemName = "";
  File? _selectedImage;
  String newDocumentId = ""; // Declare the newDocumentId variable here
  String imageUrl = ""; // Initialize with an empty string

  Future<void> _selectAndUploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      // Generate a new unique ID for the document
      newDocumentId =
          FirebaseFirestore.instance.collection('Bikes').doc().id;

      // Upload the image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${newDocumentId}_${_selectedCategory}.jpg');
      final uploadTask = storageRef.putFile(_selectedImage!);
      final TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});

      // Get the download URL of the uploaded image
      // final String imageUrl = await storageSnapshot.ref.getDownloadURL();
      imageUrl = await storageSnapshot.ref.getDownloadURL();
    }
  }

  Future<void> _retrieveAndSaveImageUrl(String partId) async {
    // Retrieve the imageUrl from Firebase Storage based on the bookId
    String imageUrl = await FirebaseStorage.instance
        .ref('images/$partId.jpg') // Replace with your storage path
        .getDownloadURL();

    // Create a new Firestore document and set the data
    Map<String, dynamic> itemData = {
      'partId': partId,
      'imageUrl': imageUrl,
    };

    // Save the data in Firestore
    await FirebaseFirestore.instance
        .collection('Bikes')
        .doc(partId)
        .set(itemData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Upload Bikes",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30.0),
              CircleAvatar(
                backgroundImage:
                    _selectedImage != null ? FileImage(_selectedImage!) : null,
                radius: 50.0,
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _selectAndUploadImage,
                  tooltip: 'Upload Picture',
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text("Upload Picture"),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    itemName = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Item Name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: <String>[
                  "Honda",
                  "Yamaha",
                  "Suzuki",
                  "Road Prince",
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Select Model",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              // DropdownButtonFormField<String>(
              //   value: _selectedSection,
              //   onChanged: (newValue) {
              //     setState(() {
              //       _selectedSection = newValue!;
              //     });
              //   },
              //   items: <String>[
              //     "Brand New",
              //     "Used Item",

              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   decoration: InputDecoration(
              //     labelText: "Select Section",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    itemPrice = value;
                  });
                },
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true), // Allow decimal input
                decoration: InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
              ),

              // SizedBox(height: 16.0),
              // InkWell(
              //   onTap: _selectDateAndTime,
              //   child: InputDecorator(
              //     decoration: InputDecoration(
              //       labelText: "Return Date",
              //       border: OutlineInputBorder(),
              //     ),
              //     child: Text(
              //       "${_selectedDateTime.toLocal()}".split(' ')[0],
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: ElevatedButton(
                  onPressed: () async {
                    if (itemName.isEmpty || itemPrice.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Item and Price cannot be empty."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    try {
                      double.parse(
                          itemPrice); // Check if the price can be parsed as a double
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Invalid Price format."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    // Generate a new unique ID for the document
                    String newDocumentId = FirebaseFirestore.instance
                        .collection('Bikes')
                        .doc()
                        .id;

                    Map<String, dynamic> itemData = {
                      'partId': newDocumentId,
                      'itemName': itemName,
                      'category': _selectedCategory,
                      // 'section': _selectedSection,
                      'price': itemPrice, // Add
                      // 'returnDate': _selectedDateTime,
                      'imageUrl':
                          imageUrl, // This is the image URL obtained after uploading
                    };

                    await FirebaseFirestore.instance
                        .collection('Bikes')
                        .doc(newDocumentId)
                        .set(itemData);

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.green, size: 48),
                              SizedBox(height: 16),
                              Text("Item Uploaded",
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        );
                      },
                    ).then((value) {
                      // Navigate to the next screen after the dialog is closed
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Upload_Admin()),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 61, 60, 61),
                  ),
                  child: Text("Upload"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
