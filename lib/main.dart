import 'package:flutter/material.dart';
import 'package:task_/home.dart';
import 'package:task_/views/moreP.dart';

// void main() {
//   runApp(const MaterialApp(
//     // home: Home(),

//   ));
// }
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const Home(),
      '/more': (context) => const More(),
    },
  ));
}
