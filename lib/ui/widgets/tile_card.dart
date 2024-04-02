import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class TileCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  const TileCard({
    super.key,
    required this.title,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imgUrl,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
