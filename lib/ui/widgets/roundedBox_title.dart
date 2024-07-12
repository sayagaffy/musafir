import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class RoundedBoxTitle extends StatelessWidget {
  final String title;

  final Icon icon;
  const RoundedBoxTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kWhiteColor,
        border: Border.all(
          color: const Color(0xFFD9D9D9),
        ),
      ),
      padding: const EdgeInsets.only(left: 18, right: 18),
      margin: const EdgeInsets.only(
        left: 18,
        right: 18,
        bottom: 18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            width: 12,
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
