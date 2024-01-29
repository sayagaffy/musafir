import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/search_page.dart';
import 'package:musafir/ui/widgets/custom_page_route.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CustomPageRoute(
          child: const SearchPage(),
          direction: AxisDirection.left,
        ));
      },
      child: Container(
        height: 32,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: kGreyColor,
          ),
          borderRadius: BorderRadius.circular(defaultRadius),
          color: kBackgroundColor,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search_rounded,
              size: 20,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              'Cari di Musafir',
              style: greyTextStyle.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
