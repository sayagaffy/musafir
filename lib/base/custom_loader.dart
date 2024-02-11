import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/shared/theme.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    // print("I am orintting laoding state " +
    //     Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99.0),
          color: kBlueColor,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
