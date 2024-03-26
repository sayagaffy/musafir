import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class CurrentSetLocation extends StatelessWidget {
  final String activeAddress;
  const CurrentSetLocation({super.key, required this.activeAddress});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          horizontalTitleGap: 8,
          leading: Icon(
            Icons.my_location_rounded,
            size: 25,
            color: kWarningMain,
          ),
          title: Text(
            'Lokasi yang kamu set sekarang',
            style: blackTextStyle.copyWith(
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            activeAddress == 'none'
                ? 'perbaharui terlebih dahulu lokasi kamu'
                : activeAddress,
            style: greyTextStyle.copyWith(fontSize: 11),
            maxLines: 4,
          ),
        )
      ],
    );
  }
}
