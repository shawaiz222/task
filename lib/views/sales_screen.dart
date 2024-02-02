import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(),
      backgroundColor: Colors.red,
      body: const Center(
        child: Column(children: [
          Text('Sales Screen'),
        ]),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
