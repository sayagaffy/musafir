import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class CardRecom extends StatelessWidget {
  final String name;
  final String city;
  final String imgUrl;
  final double rating;
  final bool isMasjid;
  final EdgeInsets margin;
  final int ulasan;
  final String km;
  final String origin;
  final String destination;
  final String halalStatus;

  const CardRecom({
    super.key,
    required this.name,
    required this.city,
    this.rating = 0.0,
    this.isMasjid = false,
    this.margin = const EdgeInsets.only(right: 15),
    this.ulasan = 0,
    this.imgUrl = 'none',
    this.km = '0.4 km',
    this.origin = 'none',
    this.destination = 'none',
    this.halalStatus = '1',
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
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1.5, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                image: imgUrl == 'none'
                    ? const DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/brandBlue.png'),
                      )
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imgUrl),
                      ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 10,
              ),
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
                  Container(
                    margin: const EdgeInsets.only(top: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          city,
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: !isMasjid ? 2 : 3,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        SizedBox(
                          child: !isMasjid
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          margin: const EdgeInsets.only(
                                            right: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(halalStatus ==
                                                      '1'
                                                  ? 'assets/icon_halal.png'
                                                  : halalStatus == '2'
                                                      ? 'assets/icon_halal_blue.png'
                                                      : 'assets/icon_halal_black.png'),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          halalStatus == '1'
                                              ? 'Halal Certified'
                                              : halalStatus == '2'
                                                  ? 'Halal Friendly'
                                                  : 'Halal',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: bold,
                                            color: halalStatus == '1'
                                                ? kGreenHover
                                                : halalStatus == '2'
                                                    ? kBlueColorHover
                                                    : kBlackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        destination != 'none' &&
                                                destination != 'ZERO_RESULTS'
                                            ? Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                    size: 16,
                                                    color: kRedMain,
                                                  ),
                                                  Text(
                                                    '${destination}Km',
                                                    style: blackTextStyle
                                                        .copyWith(fontSize: 11),
                                                  ),
                                                ],
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(
                                  height: 1,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
