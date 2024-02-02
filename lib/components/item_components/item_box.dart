import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';

class ItemBox extends StatelessWidget {
  final String name;
  final String? shortName;
  final double? price;
  final Function(String id)? onTap;
  final Function(String id)? onLongPress;
  final Function(String id)? onSelect;
  final List<String>? selected;
  final String id;
  final bool selectable;
  const ItemBox({
    Key? key,
    required this.name,
    this.shortName,
    this.price,
    this.onLongPress,
    this.onTap,
    this.onSelect,
    required this.id,
    this.selected,
    this.selectable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress != null ? () => onLongPress!(id) : null,
      onTap: selectable
          ? () {
              onSelect!(id);
            }
          : onTap != null
              ? () => onTap!(id)
              : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: ThemeColors.borderColor)),
        ),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: ThemeColors.lightGrayColor,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                shortName ?? name[0].toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ThemeColors.grayColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            const SizedBox(width: 12),
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
            if (selectable)
              Checkbox(
                value: selected!.contains(id),
                onChanged: (e) {
                  () => onSelect!(id);
                },
                shape: const CircleBorder(),
              )
            else
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
