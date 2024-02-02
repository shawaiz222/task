import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';

class VariationBox extends StatelessWidget {
  final String name;
  final double? price;
  final bool last;
  final Function()? onTap;
  const VariationBox({
    Key? key,
    required this.name,
    this.price,
    this.onTap,
    this.last = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, right: 10, left: 13),
        decoration: BoxDecoration(
          border: !last
              ? const Border(bottom: BorderSide(color: ThemeColors.borderColor))
              : null,
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
            price != null
                ? Text(
                    '$price\$',
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
