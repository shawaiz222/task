import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

PreferredSizeWidget emptyAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(0.0),
    child: AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );
}
