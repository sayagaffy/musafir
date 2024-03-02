import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/review_rate_page.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/custom_page_route.dart';

import 'package:musafir/ui/widgets/custom_title.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  Widget backgroundImage(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.dstATop),
          child: Container(
            height: 245,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image_destination1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          margin: const EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.keyboard_backspace_rounded,
                  size: 35,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _dialogBuilder(context);
                },
                child: const Icon(
                  Icons.more_horiz,
                  size: 35,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 18,
          ),
          margin: const EdgeInsets.only(
            top: 150,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halal Guys',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Burger, Fried chicken, Kebab...',
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.bookmark_border_rounded,
                size: 30,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget tileReview() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            height: 56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_outline_rounded,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      '4.7',
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '1.200 rating',
                  style: blackTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            height: 56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.place,
                      size: 20,
                    ),
                    Text(
                      '3,63 km',
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Jarak',
                  style: blackTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            height: 56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.attach_money_rounded,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      '4.7',
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '30rb-70rb',
                  style: blackTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget content() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 23),
      margin: const EdgeInsets.only(top: 19),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status',
            style: blackTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 3),
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFFE6E8EA),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                const Icon(
                  Icons.check_box_outline_blank_rounded,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Halal Certified',
                  style: blackTextStyle,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Alamat',
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Jl. Sukamenak No. 55 Kec. margahayu, Bandung, Jawa Barat',
            style: blackTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget mapLocation() {
    return Container(
      margin: const EdgeInsets.only(
        top: 14,
        bottom: 33,
      ),
      width: double.infinity,
      height: 188,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image_map.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget titleRekomendasi() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 5,
      ),
      padding: const EdgeInsets.only(left: 25, right: 23),
      child: const CustomTitle(title: 'Foto'),
    );
  }

  Widget foto() {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Row(
          children: [
            Container(
              width: 92,
              height: 121,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF5F5F5),
              ),
            ),
            Container(
              width: 92,
              height: 121,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF5F5F5),
              ),
            ),
            Container(
              width: 92,
              height: 121,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF5F5F5),
              ),
            ),
            Container(
              width: 92,
              height: 121,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF5F5F5),
              ),
            ),
            Container(
              width: 92,
              height: 121,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF5F5F5),
              ),
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

  Widget rating(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beri rating dan ulasan',
            style: blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: bold,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 31,
                width: 31,
                margin: const EdgeInsets.only(
                  top: 15,
                  right: 15,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/image_destination1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      child: const ReviewRatePage(),
                      direction: AxisDirection.up,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.star_outline_rounded,
                        size: 35,
                        color: Color(0xFFD9D9D9),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star_outline_rounded,
                        size: 35,
                        color: Color(0xFFD9D9D9),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star_outline_rounded,
                        size: 35,
                        color: Color(0xFFD9D9D9),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star_outline_rounded,
                        size: 35,
                        color: Color(0xFFD9D9D9),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.star_outline_rounded,
                        size: 35,
                        color: Color(0xFFD9D9D9),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget titleUlasan() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 11,
        top: 27,
      ),
      padding: const EdgeInsets.only(left: 25, right: 23),
      child: const CustomTitle(title: 'Ulasan'),
    );
  }

  Widget ulasan() {
    return Container(
      padding: const EdgeInsets.only(
        left: 25,
        right: 23,
        bottom: 50,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.star_outline_rounded,
                size: 24,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                '5.0',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                'dari 40 rating',
                style: blackTextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              const Icon(
                Icons.fiber_manual_record,
                size: 10,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                '811 ulasan',
                style: blackTextStyle.copyWith(
                  fontSize: 10,
                ),
              )
            ],
          ),
          // const UlasanCard(),
          // const UlasanCard(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kBackgroundColor,
      body: ListView(children: [
        backgroundImage(context),
        tileReview(),
        content(),
        mapLocation(),
        titleRekomendasi(),
        foto(),
        line(),
        rating(context),
        line(),
        titleUlasan(),
        ulasan(),
      ]),
    );
  }

  Future<void> _reportBuilder(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          decoration: BoxDecoration(
            color: kWhiteColor,
          ),
          width: double.infinity,
          child: (Column(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 45,
                color: kBlueColor,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Terima kasih telah memberi tahu kami',
                style: blackTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: extraBold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Kami menggunakan laporan ini untuk memberikan informasi yang terbaru dan tepat di masa mendatang.',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 100,
              ),
              CustomButton(
                title: 'Tutup',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )),
        );
      },
    );
  }

  Future<void> _showReportBuilder(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // This attribute will auto scale size of Column widget when the keyboard showed
            ),
            child: SizedBox(
              height: 320,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Apa yang ingin Anda laporkan?',
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: extraBold,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 230,
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _reportBuilder(context);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Restoran sudah tutup',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right_rounded,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  height: 1,
                                  color: Color(0xFFF3F3F3),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _reportBuilder(context);
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Restoran Tidak Halal',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right_rounded,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  height: 1,
                                  color: Color(0xFFF3F3F3),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lainnya',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      hintText: 'Tulis disini',
                                      isDense: true, // Added this
                                      contentPadding: const EdgeInsets.all(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 339,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _showReportBuilder(context);
                  },
                  child: Text(
                    'Laporkan',
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                      color: kRedColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 339,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: kWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Batalkan',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
