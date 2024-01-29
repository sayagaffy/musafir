import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/star_display_widget.dart';

class ReviewRatePage extends StatelessWidget {
  const ReviewRatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.keyboard_backspace_rounded,
                  size: 30,
                ),
              ),
              Expanded(
                child: Text(
                  'Halal Guys',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 53),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 31,
                      width: 31,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/image_destination1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Dewantara',
                      style: blackTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const StarDisplayWidget(
                  value: 2,
                  filledStar: Icon(
                    Icons.star_rounded,
                    color: Color.fromARGB(255, 255, 209, 59),
                    size: 32,
                  ),
                  unfilledStar: Icon(
                    Icons.star_border_rounded,
                    color: Colors.grey,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      hintText: 'Bagikan pengalaman Anda tentang tempat ini',
                      hintStyle: greyTextStyle,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0xFFDBDBDB),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0xFFDBDBDB),
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFDBDBDB),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.photo_camera_rounded,
                        size: 25,
                        color: Color(0xFFDBDBDB),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Tamahkan foto & video',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                      )
                    ],
                  ),
                ),
                CustomButton(
                  title: 'Posting',
                  onPressed: () {},
                  margin: const EdgeInsets.only(top: 150),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
