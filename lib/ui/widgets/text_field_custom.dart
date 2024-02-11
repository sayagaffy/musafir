import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;

  TextFieldCustom({
    super.key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: defaultMargin,
        left: defaultMargin,
        right: defaultMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        color: kWhiteColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure,
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kBlackColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(255, 3, 106, 154),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          labelText: hintText,
        ),
      ),
    );
  }
}
