import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class LocationListTile extends StatelessWidget {
  final Function() press;
  final String location;
  final Icon icon;
  const LocationListTile({
    super.key,
    required this.press,
    required this.location,
    this.icon = const Icon(
      Icons.location_pin,
      size: 20,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          contentPadding: const EdgeInsets.only(left: 15, right: 15),
          horizontalTitleGap: 8,
          leading: icon,
          title: Text(
            location,
            style: blackTextStyle.copyWith(
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 1,
          color: Color.fromARGB(105, 120, 127, 132),
        ),
      ],
    );
  }
}
