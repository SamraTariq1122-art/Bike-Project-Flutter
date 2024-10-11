// import 'package:aust_hhub/Admin_Chk/stat_Check.dart';
import 'package:bike_project/Admin/spare_Check.dart';
import 'package:flutter/material.dart';

import '../Check Uploaded/Parts_Checks.dart';
import '../Check Uploaded/bike_Check.dart';
import 'const.dart';



class AdminCheck extends StatefulWidget {
  const AdminCheck({super.key});

  @override
  State<AdminCheck> createState() => _AdminCheckState();
}

class _AdminCheckState extends State<AdminCheck>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text("Check Uploaded",style: TextStyle(color: Colors.black),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: gradient,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Uploaded Parts"),
            Tab(text: "Uploaded Bikes"),
            Tab(text: "Uploaded Spares"),
          ],
          labelColor: Colors.black, // Change this to your desired label color
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PartsListPage(),
          BikeListPage(),
          SpareListPage(),
      //  LibOrdersPage(),
          // CafeOrder(),
          //     StatOrder()         
                 ],
      ),
    );
  }
}
