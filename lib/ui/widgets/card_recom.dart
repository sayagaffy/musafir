import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class CardRecom extends StatelessWidget {
  final String name;
  final String city;
  final String halalStatus;
  final EdgeInsets margin;
  final String destination;
  final String imgUrl;
  final Map<String, dynamic> statusInfo;

  const CardRecom({
    super.key,
    required this.name,
    required this.city,
    required this.halalStatus,
    this.margin = const EdgeInsets.only(right: 15),
    this.destination = '0',
    this.imgUrl = 'none',
    required this.statusInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 178,
      margin: margin,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(77),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1.5, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ... existing image container ...
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toTitleCase(),
                  maxLines: 1,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: extraBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  city,
                  style: blackTextStyle.copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      margin: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(statusInfo['icon']),
                        ),
                      ),
                    ),
                    Text(
                      statusInfo['displayText'],
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: bold,
                        color: statusInfo['text'],
                      ),
                    ),
                    if (destination != 'none' &&
                        destination != 'ZERO_RESULTS') ...[
                      const SizedBox(width: 10),
                      Icon(Icons.location_on_rounded,
                          size: 16, color: kRedMain),
                      Text(
                        '${destination}Km',
                        style: blackTextStyle.copyWith(fontSize: 11),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
