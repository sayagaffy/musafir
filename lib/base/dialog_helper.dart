import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
  }) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description ?? '',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  static void showSnackBar(
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
        style: whiteTextStyle,
      ),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
    );
  }

  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: kBlueColor,
              ),
              const SizedBox(height: 15),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
