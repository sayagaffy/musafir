import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';

void showCustomSnackBar(
  String message, {
  bool isError = true,
  String title = "Error",
  Color backgroundColor = const Color(0xffFDB82C),
}) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: blackTextStyle,
    ),
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
  );
}
