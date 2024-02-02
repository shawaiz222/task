import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final String value;
  final Function(String?) onChanged;
  final String? placeholder;
  final String? error;
  final bool hasBorder;
  final bool bottomBorder;
  final bool borderRadiusTop;
  const CustomDatePicker({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.placeholder,
    this.error,
    this.hasBorder = true,
    this.bottomBorder = true,
    this.borderRadiusTop = true,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000, 8),
              lastDate: DateTime(2101),
            );
            if (picked != null) {
              onChanged(picked.toString());
            }
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 14),
            decoration: BoxDecoration(
              border: hasBorder
                  ? bottomBorder
                      ? Border.all(
                          color: error != null
                              ? ThemeColors.redColor
                              : ThemeColors.borderColor)
                      : const Border(
                          bottom: BorderSide(
                              width: 1, color: ThemeColors.borderColor),
                          top: BorderSide(
                              width: 1, color: ThemeColors.borderColor),
                          left: BorderSide(
                              width: 1, color: ThemeColors.borderColor),
                          right: BorderSide(
                              width: 1, color: ThemeColors.borderColor),
                        )
                  : const Border(
                      bottom:
                          BorderSide(width: 1, color: ThemeColors.borderColor),
                      top: BorderSide(width: 0, color: ThemeColors.borderColor),
                      left:
                          BorderSide(width: 0, color: ThemeColors.borderColor),
                      right:
                          BorderSide(width: 0, color: ThemeColors.borderColor),
                    ),
              borderRadius: hasBorder
                  ? bottomBorder
                      ? borderRadiusTop
                          ? BorderRadius.circular(8)
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            )
                      : borderRadiusTop
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )
                          : null
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          value.isNotEmpty &&
                                  value != 'null' &&
                                  value.split(' ').length > 1
                              ? value.split(' ')[0]
                              : placeholder ?? 'None',
                          style: TextStyle(
                              color: value.isNotEmpty
                                  ? Colors.black
                                  : ThemeColors.grayColor,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              error!,
              style: const TextStyle(
                color: ThemeColors.redColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
