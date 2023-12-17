// import 'package:flutter/material.dart';

// class B_nav extends StatefulWidget {
//   const B_nav({super.key});

//   @override
//   State<B_nav> createState() => _B_navState();
// }

// class _B_navState extends State<B_nav> {
//   int bottomindex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.auto_awesome_mosaic,
//             ),
//             label: "Checkout",
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.compare_arrows,
//               ),
//               label: "Transections"),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.assignment_turned_in_outlined,
//               ),
//               label: "Orders"),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.menu,
//             ),
//             label: "More",
//           )
//         ],
//         onTap: (index) {
//           setState(() {
//             bottomindex = index;
//           });
//         },
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.black,
//         unselectedLabelStyle:
//             const TextStyle(fontSize: 15, color: Colors.black),
//         currentIndex: bottomindex,
//         showUnselectedLabels: true,
//         selectedLabelStyle: const TextStyle(fontSize: 15, color: Colors.blue));
//   }
// }
