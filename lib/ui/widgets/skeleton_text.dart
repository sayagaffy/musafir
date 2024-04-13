import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonText extends StatelessWidget {
  final double size;
  const SkeletonText({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Skeletonizer(
        enabled: true,
        child: Text(
          'Assalamualaikum Mas bro',
          style: blackTextStyle.copyWith(fontSize: size),
        ),
      ),
    );
  }
}
