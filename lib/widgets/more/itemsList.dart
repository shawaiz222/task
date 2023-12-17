// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 1,
        ))),
        child: ListTile(
          leading: Icon(CupertinoIcons.cube),
          title: Text("Products"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 1,
        ))),
        child: ListTile(
          leading: Icon(Icons.assignment_turned_in_outlined),
          title: Text("Services"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 1,
        ))),
        child: ListTile(
          leading: Icon(CupertinoIcons.cube_box),
          title: Text("Stock"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 1,
        ))),
        child: ListTile(
          leading: Icon(CupertinoIcons.square_grid_2x2),
          title: Text("Categories"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 1,
        ))),
        child: ListTile(
          leading: Icon(Icons.menu_rounded),
          title: Text("Attributes"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 1,
        ))),
        child: ListTile(
          leading: Icon(Icons.shopping_bag_outlined),
          title: Text("Discounts"),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Color.fromARGB(255, 190, 190, 190),
          width: 1,
        ))),
        child: ListTile(
          leading: Icon(CupertinoIcons.rectangle_3_offgrid),
          title: Text("Units"),
        ),
      ),
    ]);
  }
}
