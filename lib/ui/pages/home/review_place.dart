import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';

class ReviewPlace extends StatefulWidget {
  final String pageId;
  final String placeName;
  final String latlng;
  final String from;
  const ReviewPlace({
    super.key,
    required this.pageId,
    required this.placeName,
    required this.latlng,
    required this.from,
  });

  @override
  State<ReviewPlace> createState() => _ReviewPlaceState();
}

class _ReviewPlaceState extends State<ReviewPlace> {
  String? name;
  String? authorPhotoUrl;
  String rate = '0';
  String? authorEmail;
  var reviewController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    UserStore().getUserDetail().then((value) {
      setState(() {
        name = value['firstName'] ?? value['username'];
        authorPhotoUrl = value['profilePhoto'] ?? 'none';
        authorEmail = UserStore().auth.currentUser!.email;
      });
    });
  }

  void _posting() {
    String review = reviewController.text.trim();

    if (review.isEmpty) {
      showCustomSnackBar("text review tidak boleh kosong", title: 'Review');
    } else if (review.length < 6) {
      showCustomSnackBar("text review  can not  be less  than six characters",
          title: 'Review');
    } else {
      UserStore().postingReview(
        widget.pageId,
        widget.latlng,
        name.toString(),
        authorEmail.toString(),
        authorPhotoUrl.toString(),
        rate.toString(),
        review,
        widget.placeName,
        widget.from,
      );
    }
  }

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
                  Get.back();
                },
                child: const Icon(
                  Icons.keyboard_backspace_rounded,
                  size: 30,
                ),
              ),
              Expanded(
                child: Text(
                  widget.placeName,
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
                      name.toString(),
                      style: blackTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      unratedColor: kNeutral40,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          rate = rating.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      rate,
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: TextField(
                    controller: reviewController,
                    textInputAction: TextInputAction.done,
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
                  onPressed: () {
                    _posting();
                  },
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
