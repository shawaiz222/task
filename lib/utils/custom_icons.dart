import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcons {
  static String get backIcon => 'assets/icons/back_icon.svg';
  static String get userIcon => 'assets/icons/user_icon.svg';
  static String get passwordIcon => 'assets/icons/password_icon.svg';
  static String get eyeIcon => 'assets/icons/eye_icon.svg';
  static String get eyeSlashIcon => 'assets/icons/eye_slash_icon.svg';
  static String get mailIcon => 'assets/icons/mail_icon.svg';
  static String get otpIcon => 'assets/icons/otp_icon.svg';
  static String get checkoutIcon => 'assets/icons/checkout_icon.svg';
  static String get transactionsIcon => 'assets/icons/transactions_icon.svg';
  static String get salesIcon => 'assets/icons/sales_icon.svg';
  static String get moreIcon => 'assets/icons/more_icon.svg';
  static String get resportsIcon => 'assets/icons/reports_icon.svg';
  static String get itemsIcon => 'assets/icons/items_icon.svg';
  static String get expensesIcon => 'assets/icons/expenses_icon.svg';
  static String get usersIcon => 'assets/icons/users_icon.svg';
  static String get settingsIcon => 'assets/icons/settings_icon.svg';
  static String get logsIcon => 'assets/icons/logs_icon.svg';
  static String get logoutIcon => 'assets/icons/logout_icon.svg';
  static String get productsIcon => 'assets/icons/products_icon.svg';
  static String get servicesIcon => 'assets/icons/services_icon.svg';
  static String get stocksIcon => 'assets/icons/stocks_icon.svg';
  static String get categoriesIcon => 'assets/icons/categories_icon.svg';
  static String get attributesIcon => 'assets/icons/attributes_icon.svg';
  static String get discountsIcon => 'assets/icons/discounts_icon.svg';
  static String get unitsIcon => 'assets/icons/units_icon.svg';
  static String get searchIcon => 'assets/icons/search_icon.svg';
  static String get arrowRightIcon => 'assets/icons/arrow_right_icon.svg';
  static String get plusIcon => 'assets/icons/plus_icon.svg';
  static String get imageIcon => 'assets/icons/image_icon.svg';
  static String get rolesIcon => 'assets/icons/roles_icon.svg';
}

class CustomIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final Color? color;
  const CustomIcon({Key? key, required this.icon, this.size = 20, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      constraints: BoxConstraints(
        maxHeight: size!,
        maxWidth: size!,
        minHeight: size!,
        minWidth: size!,
      ),
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
