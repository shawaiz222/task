import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoder_app/utils/colors.dart';

enum SnackType { success, error, warning }

class Snackbar {
  static void show({
    required String message,
    SnackType type = SnackType.success,
  }) {
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: type == SnackType.success
          ? ThemeColors.greenColor
          : type == SnackType.error
              ? ThemeColors.redColor
              : Colors.orange,
      margin: const EdgeInsets.all(0),
      borderRadius: 0,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      messageText: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      onTap: (value) => Get.back(),
    );
  }
}
