import 'package:flutter/material.dart';
import 'package:invoder_app/utils/colors.dart';
import '../../components/ui/index.dart';
import 'package:get/get.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  const DefaultAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const SizedBox(),
      toolbarHeight: 50,
      flexibleSpace: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: ThemeColors.borderColor,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIconButton(
                icon: Icons.arrow_back,
                size: CustomIconButtonSize.small,
                variant: CustomIconButtonVariant.light,
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Get.back();
                  } else {
                    Get.offAllNamed('/home');
                  }
                },
              ),
              title is Widget
                  ? title
                  : Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              const SizedBox(width: 42),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
