import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/home/utils/halal_status_util.dart';

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
  final int halalStatus;

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
    this.halalStatus = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
        minWidth: 160,
        maxHeight: 320, // Reduced max height
        minHeight: 220, // Added minimum height
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: imgUrl == 'none'
                    ? Image.asset(
                        'assets/brandBlue.png',
                        fit: BoxFit.contain,
                      )
                    : Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/brandBlue.png',
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: extraBold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    city,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 8),
                  if (!isMasjid) ...[
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                HalalStatusUtil.getStatusInfo(
                                    halalStatus)['icon'],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            HalalStatusUtil.getStatusInfo(
                                halalStatus)['displayText'],
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: bold,
                              color: HalalStatusUtil.getStatusInfo(
                                  halalStatus)['text'],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/icon_star.png'),
                                  ),
                                ),
                              ),
                              Text(
                                rating.toString(),
                                style: greyTextStyle.copyWith(fontSize: 12),
                                overflow: TextOverflow.fade,
                              ),
                              Expanded(
                                child: Text(
                                  ' | $ulasan ulasan',
                                  style: greyTextStyle.copyWith(fontSize: 12),
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icon_dots.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
