import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:musafir/base/dialog_helper.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

class UserStore {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // collection reference
  final CollectionReference dbUsers =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference dbReviews =
      FirebaseFirestore.instance.collection('reviews');

  Future createUser({
    String? username,
    String? bio,
    String? photoURL,
    String? firstName,
    String? lastName,
    String? phone,
    String? provider,
    String? address,
    String? latlang,
  }) async {
    return await dbUsers.doc(auth.currentUser!.email).set({
      'username': username,
      'bio': bio,
      'profilePhoto': photoURL,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'provider': provider,
      'address': address,
      'lat': latlang,
      'long': latlang,
      'creatAt': DateTime.now(),
    });
  }

  Future getUserDetail() async {
    return await dbUsers
        .doc(auth.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        return ('Document does not exist on the database');
      }
    });
  }

  Future updateUserData(dynamic data) async {
    try {
      final querySnapshot =
          await dbUsers.doc(auth.currentUser!.email).update(data);
      return querySnapshot;
    } catch (error) {
      showCustomSnackBar(error.toString());
      throw 'failed';
    }
  }

  Future postingReview(
    String placeid,
    String latlang,
    String authorName,
    String authorEmail,
    String authorPhotoUrl,
    String rating,
    String review,
    String page,
    String from,
  ) async {
    DialogHelper.showLoading('Posting Review..');

    return await dbReviews.doc().set({
      'place_id': placeid,
      'latlang': latlang,
      'author_name': authorName,
      'author_email': authorEmail,
      'profile_photo_url': authorPhotoUrl,
      'rating': rating,
      'text': review,
      'creatAt': DateTime.now(),
    }).then((value) {
      DialogHelper.hideLoading();

      DialogHelper.showSnackBar(
        'Berhasil posting reviews',
        title: 'Successfuly',
        backgroundColor: kSuccessMain,
      );

      Timer(const Duration(seconds: 5), () {
        if (from == 'homePage') Get.toNamed(RouteHelper.getInitial());
      });
    }).catchError((error) {
      DialogHelper.showErroDialog(description: error.toString());
    });
  }

  Future checkUserReview(String placeId) async {
    dynamic review;
    await dbReviews
        .where("place_id", isEqualTo: placeId)
        .where('author_email', isEqualTo: auth.currentUser!.email)
        .get()
        .then(
          (QuerySnapshot docs) => {
            for (var element in docs.docs) {review = element.data()},
          },
        );
    return review;
  }

  ///[Expample void]
  // void getDataUser() async {
  //   var locationController = Get.find<LocationController>();

  //   var authC = Get.find<AuthController>();
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(authC.auth.currentUser!.email)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       Map<String, dynamic> data =
  //           documentSnapshot.data() as Map<String, dynamic>;

  //       setState(() {
  //         name = data['firstName'];
  //         address = data['address'];
  //         latlang = data['lat'] != null
  //             ? '${data['lat']},${data['long']}'
  //             : locationController.latlng.toString();
  //       });
  //     } else {
  //       return ('Document does not exist on the database');
  //     }
  //   });
  // }
}
