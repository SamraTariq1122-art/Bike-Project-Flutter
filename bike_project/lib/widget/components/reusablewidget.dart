import 'package:flutter/material.dart';
class ReuseableWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const ReuseableWidget({required this.title,required this.icon});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        constraints: BoxConstraints.expand(
          height : MediaQuery.of(context).size.height * 0.24,

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,size: 40,),
            Text(title,style: TextStyle(fontSize: 14),)
          ],
        ),
        color: Colors.blue.shade100,
      ),
    );
  }
}
