import 'package:flutter/material.dart';

import 'package:musafir/shared/theme.dart';

class TextFdCustom extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final IconData icon;
  final Function() onTap;
  final bool readOnly;

  const TextFdCustom({
    super.key,
    required this.textController,
    required this.labelText,
    required this.icon,
    required this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        style: blackTextStyle.copyWith(
          fontSize: 14,
        ),
        textAlignVertical: TextAlignVertical.center,
        controller: textController,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: blackTextStyle.copyWith(
            color: kGreyColor,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Color(0xFFFE6E8EA),
          prefixIcon: Icon(
            icon,
            color: kBlueColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        readOnly: readOnly,
        onTap: onTap,
      ),
    );
  }
}
