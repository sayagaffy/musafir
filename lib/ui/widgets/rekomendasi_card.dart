import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/location_text.dart';

class RekomendasiCard extends StatelessWidget {
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

  const RekomendasiCard({
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 178,
      height: !isMasjid ? 206 : 175,
      margin: margin,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1.5, 2),
          ),
        ],
      ),
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
                  name,
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
                        maxLines: !isMasjid ? 1 : 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          GetLocationText(
                            origin: origin,
                            destination: destination,
                          ),
                        ],
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
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icon_halal.png'),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Halal Certified',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: bold,
                                          color: kGreenHover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            margin:
                                                const EdgeInsets.only(right: 3),
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/icon_star.png'),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            rating.toString(),
                                            style: greyTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                          Text(
                                            ' |',
                                            style: blackTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                          Text(
                                            ' $ulasan ulasan ',
                                            style: greyTextStyle.copyWith(
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: 14,
                                        height: 14,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icon_dots.png'),
                                          ),
                                        ),
                                      )
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
    );
  }
}
