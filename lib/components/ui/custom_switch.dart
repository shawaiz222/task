import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/utils/colors.dart';

class CustomSwitch extends StatefulWidget {
  final String label;
  final bool value;
  final Function(bool?) onChanged;
  const CustomSwitch({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.label,
            style: Get.textTheme.bodySmall!.copyWith(
              color: primaryColor.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: FittedBox(
            child: Switch(
              value: widget.value,
              onChanged: widget.onChanged,
              activeColor: Colors.white,
              activeTrackColor: primaryColor.shade500,
              inactiveThumbColor: primaryColor.shade900,
              inactiveTrackColor: ThemeColors.lightColor,
              trackOutlineWidth: MaterialStateProperty.resolveWith(
                (states) => 0.01,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
