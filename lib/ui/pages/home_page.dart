import 'package:musafir/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:musafir/ui/widgets/custom_title.dart';
import 'package:musafir/ui/widgets/rekomendasi_card.dart';
import 'package:musafir/ui/widgets/tile_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget header() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: defaultMargin,
        top: 20,
        bottom: 9,
        right: defaultMargin,
      ),
      decoration: const BoxDecoration(color: Color(0xFFE6E8EA)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assalamualaikum, Habib',
            style: blackTextStyle.copyWith(
              fontWeight: bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            height: 32,
            child: TextField(
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
                color: kBlackColor,
              ),
              textAlignVertical: TextAlignVertical.center,
              cursorColor: kBlackColor,
              decoration: InputDecoration(
                fillColor: kWhiteColor,
                contentPadding: const EdgeInsets.all(10.0),
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                hintText: 'Cari di musafir,',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    defaultRadius,
                  ),
                  borderSide: BorderSide(
                    color: kGreyColor,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 14,
                  width: 14,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon_location.png'),
                    ),
                  ),
                ),
                Text(
                  'Kamu sedang berada di',
                  style: blackTextStyle.copyWith(
                      fontSize: 10, fontWeight: regular),
                ),
                Text(
                  ' Kawashima',
                  style:
                      blackTextStyle.copyWith(fontSize: 10, fontWeight: bold),
                ),
                Container(
                  height: 14,
                  width: 14,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon_dropdown.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleRekomendasi() {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: const CustomTitle(title: 'Rekomendasi'),
    );
  }

  Widget rekomendasi() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin),
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

  Widget line() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 25),
      height: 7,
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
    );
  }

  Widget titleKategoriMakanan() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: const CustomTitle(title: 'Kategori Makanan'),
    );
  }

  Widget kategoriMakanan() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            TileCard(
              title: 'Algerian',
              imgUrl: 'assets/image_destination3.png',
            ),
            TileCard(
              title: 'Desert',
              imgUrl: 'assets/image_destination2.png',
            ),
            TileCard(
              title: 'Hindi',
              imgUrl: 'assets/image_destination1.png',
            ),
            TileCard(
              title: 'Bake',
              imgUrl: 'assets/image_destination4.png',
            ),
            TileCard(
              title: 'Pizza',
              imgUrl: 'assets/image_destination2.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget titleRekomendasiMasjid() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: const CustomTitle(title: 'Masjid Tedekat'),
    );
  }

  Widget rekomendasiMasjid() {
    return Container(
      padding: EdgeInsets.only(left: defaultMargin, bottom: 50),
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            RekomendasiCard(
              name: 'Al-Azhar',
              city: 'Kota Jakarta Selatan',
              imgUrl: 'assets/image_destination1.png',
              rating: 4.7,
            ),
            RekomendasiCard(
              name: 'Masjid Besar Al-ihsan',
              city: 'Nagasaki, Jepang',
              imgUrl: 'assets/image_destination2.png',
              rating: 4.3,
            ),
            RekomendasiCard(
              name: 'Ar-Rahman',
              city: 'Jakarta, Indonesia',
              imgUrl: 'assets/image_destination3.png',
              rating: 4.8,
            ),
            RekomendasiCard(
              name: 'Al-irsyad Satya',
              city: 'Tebet, Bandung',
              imgUrl: 'assets/image_destination4.png',
              rating: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        header(),
        titleRekomendasi(),
        rekomendasi(),
        line(),
        titleKategoriMakanan(),
        kategoriMakanan(),
        line(),
        titleRekomendasiMasjid(),
        rekomendasiMasjid(),
      ],
    );
  }
}
