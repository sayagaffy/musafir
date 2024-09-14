import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class ListTile1 extends StatelessWidget {
  final String title;
  final String address;
  final bool isSelected;
  final int index;
  final String halalStatus;
  final String destination;
  final String photos;
  final String placeId;
  final Function() onTap;
  final bool showCheckbox;
  const ListTile1(
    placesData, {
    super.key,
    required this.title,
    required this.address,
    required this.isSelected,
    required this.index,
    required this.halalStatus,
    required this.destination,
    required this.photos,
    required this.placeId,
    this.showCheckbox = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: kNeutral20,
      color: kBackgroundColor,
      child: ListTile(
        leading: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: photos == 'none'
                ? const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image_destination1.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${AppConstans.PLACE_PHOTO}$photos'),
                  ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child:
                  Text(title, style: blackTextStyle.copyWith(fontWeight: bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                address,
                style: blackTextStyle.copyWith(fontSize: 11),
                maxLines: 2,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SizedBox(
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.only(
                    right: 3,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(halalStatus == '1'
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
                destination != 'none' && destination != 'ZERO_RESULTS'
                    ? Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: kRedMain,
                          ),
                          Text(
                            '${destination}Km',
                            style: blackTextStyle.copyWith(fontSize: 11),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        trailing: showCheckbox
            ? isSelected
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green[700],
                  )
                : const Icon(
                    Icons.check_circle_outline,
                    color: Colors.grey,
                  )
            : const SizedBox(),
        onTap: onTap,
      ),
    );
  }
}
