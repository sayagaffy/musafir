import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          cardPerjalanan(),
        ],
      ),
    );
  }
}
