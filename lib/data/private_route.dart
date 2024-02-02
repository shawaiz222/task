import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class PrivateRouteMiddleware extends GetMiddleware {
  final box = GetStorage();
  @override
  RouteSettings? redirect(String? route) {
    if (box.read('user') == null) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}
