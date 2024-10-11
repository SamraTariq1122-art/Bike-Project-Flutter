// ignore: unused_import
import 'dart:ui';

import 'package:flutter/material.dart';

import 'components/reusablewidget.dart';

class Consuntlancy extends StatelessWidget {
  const Consuntlancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.28,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo1.png'),
                ),
              ),
            ),
          ),
          Row(
            children: [
              ReuseableWidget(icon: Icons.location_on,title: 'Nearst Location',),

              SizedBox(width: 2,),
              ReuseableWidget(icon: Icons.call,title: 'Call to Mechanic',)
            ],
          ),

          SizedBox(height: 2,),
          Row(
            children: [
              ReuseableWidget(icon: Icons.construction,title: 'Guidance, to self repairng',),
              SizedBox(width: 2,),
              ReuseableWidget(icon: Icons.home,title: 'Mechanice at your Door Step',),
            ],
          ),
        ],
      ),
    );
  }
}
