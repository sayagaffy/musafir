import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/custom_title.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/textfield_date_time.dart';
import 'package:musafir/ui/widgets/textfield_search.dart';

class RencanaPage extends StatelessWidget {
  const RencanaPage({super.key});

  Widget header(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 21,
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 18,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Get.offNamed(RouteHelper.getInitial());
              // Navigator.of(context).pop();
              // Get.back();
            },
            icon: const Icon(Icons.keyboard_backspace_rounded),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            'Rencana Perjalanan',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: extraBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget contentPlan(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 34,
      ),
      padding: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextfieldDateTime(),
          const SizedBox(
            height: 10,
          ),
          const TextfieldSearch(),
          CustomButton(
            title: 'Buat',
            onPressed: () {},
            margin: const EdgeInsets.only(top: 57),
          )
        ],
      ),
    );
  }

  Widget line() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 42, bottom: 26),
      height: 7,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
    );
  }

  Widget titleTujuanPopuler() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: const CustomTitle(title: 'Tujuan Populer'),
    );
  }

  Widget tujuanPopuler() {
    return Container(
      padding: EdgeInsets.only(left: 18),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            RekomendasiCard(
              name: 'Shinju Ramen',
              city: 'Tokyo, Jepang',
              imgUrl: 'assets/image_destination1.png',
              rating: 4.7,
            ),
            RekomendasiCard(
              name: 'Burger Boss',
              city: 'Nagasaki, Jepang',
              imgUrl: 'assets/image_destination2.png',
              rating: 4.3,
            ),
            RekomendasiCard(
              name: 'The Halal Guys',
              city: 'Jakarta, Indonesia',
              imgUrl: 'assets/image_destination3.png',
              rating: 4.8,
            ),
            RekomendasiCard(
              name: 'Pecel Gairah Malam',
              city: 'Tebet, Jakarta',
              imgUrl: 'assets/image_destination4.png',
              rating: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget rekomendasiTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, top: 35),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: const CustomTitle(title: 'Rekomendasi'),
    );
  }

  Widget rekomendasi() {
    return Container(
      padding: EdgeInsets.only(left: 18),
      margin: EdgeInsets.only(bottom: 50),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            RekomendasiCard(
              name: 'The Halal Guys',
              city: 'Jakarta, Indonesia',
              imgUrl: 'assets/image_destination3.png',
              rating: 4.8,
            ),
            RekomendasiCard(
              name: 'Pecel Gairah Malam',
              city: 'Tebet, Jakarta',
              imgUrl: 'assets/image_destination4.png',
              rating: 5.0,
            ),
            RekomendasiCard(
              name: 'Shinju Ramen',
              city: 'Tokyo, Jepang',
              imgUrl: 'assets/image_destination1.png',
              rating: 4.7,
            ),
            RekomendasiCard(
              name: 'Burger Boss',
              city: 'Nagasaki, Jepang',
              imgUrl: 'assets/image_destination2.png',
              rating: 4.3,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          header(context),
          contentPlan(context),
          line(),
          titleTujuanPopuler(),
          tujuanPopuler(),
          rekomendasiTitle(),
          rekomendasi(),
        ],
      ),
    );
  }
}
