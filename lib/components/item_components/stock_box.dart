import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';

class StockBox extends StatelessWidget {
  final String name;
  final int? value;
  final Function()? onTap;
  const StockBox({
    Key? key,
    required this.name,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 13),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: ThemeColors.borderColor, width: 1),
            left: BorderSide(color: ThemeColors.borderColor, width: 1),
            right: BorderSide(color: ThemeColors.borderColor, width: 1),
            top: BorderSide(color: ThemeColors.borderColor, width: 1),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Row(
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: primaryColor.shade900,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Spacer(),
            value != null
                ? Text(
                    '$value',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: primaryColor.shade900,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                  )
                : const SizedBox(),
            const SizedBox(width: 5),
            CustomIcon(
              icon: CustomIcons.arrowRightIcon,
              size: 11,
              color: ThemeColors.grayColor,
            ),
          ],
        ),
      ),
    );
  }
}
