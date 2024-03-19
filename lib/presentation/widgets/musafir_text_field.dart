import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class MusafirTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const MusafirTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: kBlackColor),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kGreyBorderColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          )),
    );
  }
}
