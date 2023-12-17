import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_/views/Category.dart';
import 'package:task_/views/moreP.dart';
import 'package:task_/views/orders.dart';
import 'package:task_/views/transaction.dart';
import 'package:task_/widgets/bottomnavigator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomindex = 0;
  final List<Widget> pages = [
    const category(),
    const order(),
    const transection(),
    const More(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.auto_awesome_mosaic,
              ),
              label: "Checkout",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.compare_arrows,
                ),
                label: "Transections"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assignment_turned_in_outlined,
                ),
                label: "Orders"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: "More",
            )
          ],
          onTap: (index) {
            setState(() {
              bottomindex = index;
            });
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle:
              const TextStyle(fontSize: 15, color: Colors.black),
          currentIndex: bottomindex,
          showUnselectedLabels: true,
          selectedLabelStyle:
              const TextStyle(fontSize: 15, color: Colors.blue)),
      body: pages[bottomindex],
    );
  }
}
