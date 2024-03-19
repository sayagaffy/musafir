import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class RekomendasiTitle extends StatelessWidget {
  final String title;
  final Function() onTap;
  const RekomendasiTitle({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
              height: 0.6,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Lihat Semua',
            style: greyTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
              color: kBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}
