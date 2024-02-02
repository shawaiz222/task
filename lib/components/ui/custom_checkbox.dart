import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/utils/colors.dart';

class CustomCheckBox extends StatefulWidget {
  final String label;
  final bool value;
  final Function(bool?) onChanged;
  const CustomCheckBox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 26, top: 1),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: GetPlatform.isDesktop ? 1.6 : 1.5,
            ),
          ),
        ),
        Positioned(
          left: GetPlatform.isDesktop ? -5 : -14,
          top: GetPlatform.isDesktop ? -5 : -14,
          child: Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: widget.value,
              onChanged: widget.onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(
                color: ThemeColors.grayColor,
                width: 1,
              ),
              activeColor: primaryColor.shade600,
              checkColor: Colors.white,
              splashRadius: 0,
            ),
          ),
        )
      ],
    );
  }
}
