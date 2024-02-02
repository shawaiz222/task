import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:invoder_app/utils/custom_icons.dart';
import 'package:get/get.dart';
import 'package:invoder_app/components/ui/index.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String? route;
  final String icon;
  final List<Map<String, dynamic>>? subItems;
  final bool isLast;
  const MenuItem({
    Key? key,
    required this.title,
    this.route,
    required this.icon,
    this.subItems,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (subItems != null) {
          showCustomModalBottomSheet(
              context: context,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: subItems!
                        .map((e) => MenuItem(
                              title: e['title'],
                              icon: e['icon'],
                              route: e['route'],
                              isLast: subItems!.last == e,
                            ))
                        .toList(),
                  )));
        } else if (route != null) {
          Get.back();
          Get.offNamed(route!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color:
                      isLast ? Colors.transparent : ThemeColors.borderColor)),
        ),
        child: Row(
          children: [
            CustomIcon(
              icon: icon,
              size: 24,
              color: primaryColor.shade900,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: primaryColor.shade900,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
