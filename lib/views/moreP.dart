// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:task_/widgets/more/more_list.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    var maxwidth = MediaQuery.of(context).size.width;
    var maxheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: maxheight,
          width: maxwidth,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    height: maxheight * 0.16,
                    width: maxwidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Row(
                            children: [
                              const Text(
                                "Welcome Back",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(
                                width: maxwidth * 0.14,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Change Location",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ))
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Ring Hope Ltd.",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: moreList(),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
