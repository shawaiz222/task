import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String? name;
  final String? message;
  const NoData({Key? key, this.message, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
          top: MediaQuery.of(context).size.height * 0.1),
      constraints: const BoxConstraints(
        minHeight: 300,
        maxWidth: 300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/no_data.png',
            height: 150,
            width: 150,
          ),
          Text(
            name != null ? '$name not found' : 'No data found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            message != null
                ? message!
                : 'There is no data to display. Create one to get started.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
