import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/google_controller.dart';

import 'package:musafir/shared/theme.dart';

class TextfieldGoogle extends StatelessWidget {
  final String hintText;
  final Function() onTap;
  final double radius;
  const TextfieldGoogle(
      {super.key,
      required this.hintText,
      required this.onTap,
      this.radius = 25});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 18, right: 18, top: 25, bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: onTap,
                    child: const Icon(Icons.keyboard_backspace_rounded)),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: SizedBox(
                    height: 32,
                    width: double.infinity,
                    child: TextFormField(
                      onChanged: (value) {
                        Get.find<GoogleController>().getPlace(value);
                      },
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: regular,
                        color: kBlackColor,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: kBlackColor,
                      decoration: InputDecoration(
                        fillColor: kNeutral20,
                        contentPadding: const EdgeInsets.all(10.0),
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 18,
                        ),
                        hintText: hintText,
                        hintStyle: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: regular,
                          color: kNeutral70,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kNeutral20, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kNeutral20, width: 0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
