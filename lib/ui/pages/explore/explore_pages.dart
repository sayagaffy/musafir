import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List dataPlans = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    UserStore().exploreList().then((value) {
      setState(() {
        if (value != null) {
          dataPlans = value['plan'];
        }
      });
    });
  }

  Widget header() {
    return Container(
      margin: const EdgeInsets.only(top: 21, bottom: 20),
      width: double.infinity,
      child: Center(
        child: Text(
          'Explore',
          style: blackTextStyle.copyWith(
            fontSize: 16,
            fontWeight: extraBold,
          ),
        ),
      ),
    );
  }

  Widget cardPerjalanan() {
    return Container(
      margin: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 13,
        left: 15,
        right: 15,
      ),
      height: 154,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buat Rencana Perjalanan\nPertamamu!',
            style: blackTextStyle.copyWith(
              fontWeight: extraBold,
              fontSize: 18,
              height: 1.3,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Kamu bisa merencanakan perjalanan dan resto tujuanmu supaya kamu nggak bingung',
            style: greyTextStyle.copyWith(fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
            width: 80,
            child: TextButton(
              onPressed: () {
                Get.offNamed(RouteHelper.getRencanaPage());
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF9E9E9E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                'Buat',
                style: whiteTextStyle.copyWith(
                  fontSize: 10,
                  fontWeight: bold,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleRencana() {
    return Text(
      'Rencana Perjalananmu',
      style: blackTextStyle.copyWith(
        fontSize: 16,
        fontWeight: bold,
      ),
    );
  }

  Widget listPerjalanan(
      String place, String placeId, String startTime, String endTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 0,
          ),
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_pin,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      place.toString(),
                      style: blackTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      'Berangkat',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      startTime,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Text(
                      'Kembali',
                      style: blackTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      endTime,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(),
          Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: dataPlans.isNotEmpty
                ? SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleRencana(),
                        const SizedBox(
                          height: 21,
                        ),
                        SizedBox(
                          height: 450,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataPlans.length,
                            itemBuilder: (BuildContext context, index) {
                              final item = dataPlans[index];

                              return listPerjalanan(
                                item['place_name'],
                                item['place_id'],
                                item['start_time'],
                                item['end_time'],
                              );
                            },
                          ),
                        ),
                        dataPlans.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.only(top: 40),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomButton(
                                    title: 'Buat Rencana lainnya ',
                                    onPressed: () {
                                      Get.offNamed(
                                          RouteHelper.getRencanaPage());
                                    },
                                    width: 207,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )
                : cardPerjalanan(),
          ),
        ],
      ),
    );
  }
}
