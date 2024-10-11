import 'package:bike_project/Admin/uploadBike.dart';
import 'package:bike_project/Admin/upload_Spare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Lib_Upload.dart';
import 'const.dart';


class Upload_Admin extends StatefulWidget {
  const Upload_Admin({Key? key}) : super(key: key);

  @override
  State<Upload_Admin> createState() => _Upload_AdminState();
}

class _Upload_AdminState extends State<Upload_Admin>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [g1, g2],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Page",style: TextStyle(color: Colors.black),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Upload Parts" ,),
            Tab(text: "Upload Bikes"),
            Tab(text: "Upload Spare"),
          ],
          labelColor: Colors.black, // Change this to your desired label color
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Cafe_Item(),
          Bike_Upload(),
          Spare_Upload()
          // Cafe_Item(),
          // Stat_Item(),
        ],
        
      ),
    );
  }
}
