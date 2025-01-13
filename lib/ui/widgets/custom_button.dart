import 'package:flutter/material.dart';
import '../../shared/theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final Function() onPressed;
  final EdgeInsets margin;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 55,
      margin: margin,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: kBlueColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: Colors.white),
            if (icon != null) const SizedBox(width: 8),
            Text(
              title,
              style: whiteTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: 55,
//       margin: margin,
//       child: TextButton(
//         style: TextButton.styleFrom(
//           backgroundColor: kBlueColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(defaultRadius),
//           ),
//         ),
//         onPressed: onPressed,
//         child: Text(
//           title,
//           style: whiteTextStyle.copyWith(
//             fontSize: 16,
//             fontWeight: semiBold,
//           ),
//         ),
//       ),
//     );
//   }
// }
