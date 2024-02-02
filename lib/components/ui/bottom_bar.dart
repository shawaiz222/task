import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:invoder_app/utils/custom_icons.dart';

class BottomBarItem extends StatelessWidget {
  final String route;
  final String icon;
  final String title;
  const BottomBarItem({
    Key? key,
    required this.route,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String currentRoute = Get.currentRoute;
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () {
        Get.offNamed(route);
      },
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        constraints: const BoxConstraints(minWidth: 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIcon(
                icon: icon,
                size: 22,
                color: currentRoute == route
                    ? primaryColor.shade500
                    : primaryColor.shade900),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: currentRoute == route
                      ? primaryColor.shade500
                      : primaryColor.shade900),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 6),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: ThemeColors.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomBarItem(
            route: '/home',
            icon: CustomIcons.checkoutIcon,
            title: 'Checkout',
          ),
          BottomBarItem(
            route: '/sales',
            icon: CustomIcons.salesIcon,
            title: 'Sales',
          ),
          BottomBarItem(
            route: '/more',
            icon: CustomIcons.moreIcon,
            title: 'More',
          ),
        ],
      ),
    );
  }
}
