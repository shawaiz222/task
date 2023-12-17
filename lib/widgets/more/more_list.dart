// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:task_/widgets/more/itemsList.dart';

class moreList extends StatefulWidget {
  const moreList({super.key});

  @override
  State<moreList> createState() => _moreListState();
}

class _moreListState extends State<moreList> {
  @override
  Widget build(BuildContext context) {
    var maxheight = MediaQuery.of(context).size.height;
    var maxwidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
          height: maxheight * 0.65,
          width: maxwidth,
          // color: Colors.red,
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Color.fromARGB(255, 190, 190, 190),
                  width: 1,
                ))),
                child: ListTile(
                  leading: Icon(Icons.moving_outlined),
                  title: Text("Reports"),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Color.fromARGB(255, 190, 190, 190),
                  width: 1,
                ))),
                child: ListTile(
                  leading: Icon(
                    Icons.poll_outlined,
                  ),
                  title: Text("Sales"),
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
                  leading: Icon(Icons.local_offer_outlined),
                  title: Text("Items"),
                  onTap: () => displayBottomSheet(context),
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
                  leading: Icon(Icons.attach_money_outlined),
                  title: Text("Expenses"),
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
                  leading: Icon(Icons.people_outline),
                  title: Text("Customers"),
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
                  leading: Icon(Icons.groups_2_outlined),
                  title: Text("Team"),
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
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
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
                  leading: Icon(Icons.article_outlined),
                  title: Text("Logs"),
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
                  leading: Icon(Icons.logout_sharp),
                  title: Text("Logout"),
                ),
              ),
            ],
          )),
    );
  }

  Future displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 400,
              child: ItemsList(),
            ));
  }
}
