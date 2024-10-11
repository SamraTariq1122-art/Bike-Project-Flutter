// import 'package:flutter/material.dart';

// class MyList1 extends StatelessWidget {
//   final String id;
//   final String ImageUrl;
//   final String spname;
//   final int price;
//   final String dec;
//   const MyList1(
//       {required this.id,
//       required this.ImageUrl,
//       required this.spname,
//       required this.price,
//       required this.dec});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         elevation: 5,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//               child: Image.asset(
//                 ImageUrl,
//                 fit: BoxFit.fill,
//                 height: 120,
//                 width: 250,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Text(
//                 spname,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: Text(
//                 "PKR ${price.toString()}",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
