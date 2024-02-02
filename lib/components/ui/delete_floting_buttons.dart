import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';

class DeleteActionButton extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onCanceled;
  const DeleteActionButton({Key? key, this.onPressed, this.onCanceled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            onPressed: onCanceled,
            backgroundColor: ThemeColors.lightColor,
            child: Icon(
              Icons.close,
              color: primaryColor.shade900,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: Colors.red.shade900,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
