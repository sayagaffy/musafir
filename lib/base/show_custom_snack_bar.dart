import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musafir/ui/widgets/big_text.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    String title = "Error",
    Color backgroundColor = const Color(0xffFDB82C)}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(text: title, color: Colors.black),
    messageText: Text(message, style: const TextStyle(color: Colors.white)),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
  );
}
