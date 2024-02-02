import 'package:flutter/material.dart';
import 'package:invoder_app/components/ui/index.dart';
import 'package:invoder_app/components/appbars/empty_app_bar.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: emptyAppBar(),
      body: const Center(
        child: Column(children: [
          Text('Transactions Screen'),
        ]),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
