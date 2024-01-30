import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class TileTagsSearch extends StatelessWidget {
  final String title;
  const TileTagsSearch({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 75,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
