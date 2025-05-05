import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:musafir/ui/pages/home/utils/halal_status_util.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';

class ListTileCard extends StatefulWidget {
  final String title;
  final String address;
  final String imgUrl;
  final String placeId;
  final double? placeLat;
  final double? placeLng;
  final double rating;
  final int price;

  const ListTileCard({
    super.key,
    required this.title,
    required this.address,
    required this.placeId,
    this.placeLat,
    this.placeLng,
    this.imgUrl = 'none',
    this.rating = 4.5,
    this.price = 0,
  });

  @override
  _ListTileCardState createState() => _ListTileCardState();
}

class _ListTileCardState extends State<ListTileCard> {
  final homeController = Get.find<HomeController>();
  final locationController = Get.find<LocationController>();

  RxInt halalStatus = 0.obs;
  RxString distance = '?? km'.obs;

  @override
  void initState() {
    super.initState();
    _fetchHalalStatusAndDistance();
  }

  Future<void> _fetchHalalStatusAndDistance() async {
    try {
      // Fetch Halal Status
      final status =
          await homeController.getHalalStatusForPlace(widget.placeId);
      halalStatus.value = status;

      // Fetch Distance
      if (locationController.latlng != null &&
          widget.placeLat != null &&
          widget.placeLng != null) {
        final userLocation = locationController.latlng
            .toString()
            .replaceAll('LatLng(', '')
            .replaceAll(')', '');

        final placeLocation = '${widget.placeLat},${widget.placeLng}';

        final placeDistance =
            await homeController.distance(placeLocation, userLocation);

        if (placeDistance != 'zero' && placeDistance != 'ZERO_RESULTS') {
          distance.value = placeDistance;
        }
      }
    } catch (e) {
      print('Error fetching place details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 110,
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
                  image: widget.imgUrl == 'none'
                      ? const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/image_destination1.png'),
                        )
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${AppConstans.PLACE_PHOTO}${widget.imgUrl}'),
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
                        widget.title,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        widget.address,
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
                            distance.value,
                            style: noColorTextStyle.copyWith(
                              color: kNeutral90,
                              height: 1.3,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          Tooltip(
                            message: HalalStatusUtil.getStatusInfo(
                                halalStatus.value)['description'],
                            child: Container(
                              width: 16,
                              height: 16,
                              margin: const EdgeInsets.only(
                                right: 3,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      HalalStatusUtil.getStatusInfo(
                                          halalStatus.value)['icon']),
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
                            widget.rating.toString(),
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
                            children: List.generate(widget.price, (index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: index.toDouble() * 10),
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
        ));
  }
}
