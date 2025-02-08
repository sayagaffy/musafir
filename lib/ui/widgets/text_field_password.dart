import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class TextFieldPassword extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final String label;

  const TextFieldPassword({
    super.key,
    required this.textController,
    required this.hintText,
    required this.label,
  });

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            padding: const EdgeInsets.only(bottom: 3),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: kWhiteColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ],
            ),
            child: TextField(
              obscureText: passwordVisible,
              textAlignVertical: TextAlignVertical.bottom,
              controller: widget.textController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                hintText: widget.hintText,
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
