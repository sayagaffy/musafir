import 'package:flutter/widgets.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/utils/dimendsions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;

  const BigText({
    super.key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1, // Joy tashlab beradi
        overflow: overflow,
        style: blackTextStyle.copyWith(
          fontSize: size,
          color: color,
          fontWeight: semiBold,
        ));
  }
}
