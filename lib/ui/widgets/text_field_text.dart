import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

// ignore: must_be_immutable
class TextFieldText extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String label;
  final IconData icon;
  final Color bgcolor;
  final bool activeBg;
  final bool readOnly;
  final bool padding;
  final bool showIcon;

  const TextFieldText({
    super.key,
    required this.textController,
    required this.hintText,
    required this.label,
    required this.icon,
    this.activeBg = false,
    this.bgcolor = const Color(0xFFF5F5F5),
    this.readOnly = false,
    this.padding = false,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding ? 18 : 0),
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
            // padding: EdgeInsets.only(bottom: activeBg ? 0 : 3),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: activeBg ? bgcolor : kWhiteColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                showIcon ? Icon(icon) : const SizedBox(),
                Expanded(
                  child: TextField(
                    readOnly: readOnly,
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: textController,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.only(left: 8, right: 8),
                      hintText: hintText,
                      hintStyle: noColorTextStyle.copyWith(
                        fontSize: 14,
                        color: kNeutral50,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: kWhiteColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: activeBg ? bgcolor : Colors.white,
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
