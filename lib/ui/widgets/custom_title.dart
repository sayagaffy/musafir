import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  const CustomTitle({
    super.key,
    required this.title,
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
            ),
          ),
        ),
        Text(
          'Lihat Semua',
          style: greyTextStyle.copyWith(
            fontSize: 10,
            fontWeight: bold,
          ),
        ),
      ],
    );
  }
}
