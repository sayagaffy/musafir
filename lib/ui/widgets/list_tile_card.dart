import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class ListTileCard extends StatelessWidget {
  final String title;
  final String address;
  final String imgUrl;
  final String km;
  final String status;
  final double rating;
  final int price;
  final int? halalStatus;

  const ListTileCard(
      {super.key,
      required this.title,
      required this.address,
      this.imgUrl = 'none',
      this.km = '1.4',
      this.status = 'halal',
      this.rating = 4.5,
      this.price = 0,
      this.halalStatus});

  String _getHalalIcon() {
    switch (halalStatus) {
      case 1: // Halal Certified
        return 'assets/icon_halal.png';
      case 2: // Halal Friendly
        return 'assets/icon_halal_blue.png';
      case 3: // Limited Halal Options
        return 'assets/icon_halal_blue.png';
      default:
        return 'assets/icon_halal_black.png'; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: kNeutral40),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: imgUrl == 'none'
                  ? const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/image_destination1.png'),
                    )
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${AppConstans.PLACE_PHOTO}$imgUrl'),
                    ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    address,
                    style: blackTextStyle.copyWith(
                      fontSize: 12,
                      height: 1.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 15,
                        color: kRedMain,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '$km km',
                        style: noColorTextStyle.copyWith(
                          color: kNeutral90,
                          height: 1.3,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Container(
                        width: 16,
                        height: 16,
                        margin: const EdgeInsets.only(
                          right: 3,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              _getHalalIcon(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Icon(
                        Icons.star_rounded,
                        size: 15,
                        color: kSecondaryMain,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        rating.toString(),
                        style: noColorTextStyle.copyWith(
                          color: kNeutral90,
                          height: 1.3,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Stack(
                        children: List.generate(price, (index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(left: index.toDouble() * 10),
                            child: Icon(
                              Icons.attach_money_rounded,
                              size: 15,
                              color: kBlueColor,
                            ),
                          );
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
