import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  // ignore: prefer_typing_uninitialized_variables
  final iconColor;
  final double size;
  final double iconSize;

  const AppIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xFF5A5757),
    this.iconColor = const Color(0xFFDFAB0E),
    this.size = 40,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
