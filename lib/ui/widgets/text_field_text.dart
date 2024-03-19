import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

// ignore: must_be_immutable
class TextFieldText extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String label;
  final IconData icon;

  const TextFieldText({
    super.key,
    required this.textController,
    required this.hintText,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 10,
            ),
            padding: const EdgeInsets.only(bottom: 3),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
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
              textAlignVertical: TextAlignVertical.bottom,
              controller: textController,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: noColorTextStyle.copyWith(
                  fontSize: 14,
                  color: kNeutral50,
                  height: 1.4,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Color.fromARGB(255, 3, 106, 154),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
