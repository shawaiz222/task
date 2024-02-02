import 'package:flutter/material.dart';

class ContentLoader extends StatelessWidget {
  const ContentLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 10,
          top: MediaQuery.of(context).size.height * 0.25),
      constraints: const BoxConstraints(
        minHeight: 300,
        maxWidth: 300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70.0,
            width: 70.0,
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Loading data...',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
