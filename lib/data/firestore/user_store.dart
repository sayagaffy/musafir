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
  final CollectionReference dbBookmark =
      FirebaseFirestore.instance.collection('bookmark');

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
        Get.toNamed(RouteHelper.getHomeDetailPage(placeid, page, from));
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

  Future bookmarkPlace(
    String placeid,
    String latlang,
    String page,
    String from,
  ) async {
    DialogHelper.showLoading('Bookmark Place..');
    final collection = dbBookmark.doc(auth.currentUser!.email);
    final docSnap = await collection.get();
    Map<String, dynamic> payload = {
      "place_id": placeid,
      "latlang": latlang,
      'place_name': page,
      'creatAt': DateTime.now(),
    };

    return await collection
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        List cart = docSnap.get('place');
        List item = cart
            .where((element) => element['place_id'].contains(placeid))
            .toList();
        if (item.isEmpty) {
          ///[Update bookmark]
          dbBookmark.doc(auth.currentUser!.email).update({
            'place': FieldValue.arrayUnion([payload]),
          }).then((value) {
            DialogHelper.hideLoading();
            DialogHelper.showSnackBar(
              'Berhasil  bookmark tempat',
              title: 'Successfuly',
              backgroundColor: kSuccessMain,
            );
          }).catchError((error) {
            DialogHelper.showErroDialog(description: error.toString());
          });
        } else {
          ///[Remove bookmark]
          collection
              .update({'place': FieldValue.arrayRemove(item)}).then((value) {
            DialogHelper.hideLoading();
            DialogHelper.showSnackBar(
              'Berhasil Hapus bookmark tempat',
              title: 'Successfuly',
              backgroundColor: kSuccessMain,
            );
          }).catchError((error) {
            DialogHelper.showErroDialog(description: error.toString());
          });
        }
      } else {
        ///[Create if colection not ready yet]
        dbBookmark.doc(auth.currentUser!.email).set({
          'place': FieldValue.arrayUnion([payload]),
        }).then((value) {
          DialogHelper.hideLoading();
          DialogHelper.showSnackBar(
            'Berhasil bookmark tempat',
            title: 'Successfuly',
            backgroundColor: kSuccessMain,
          );
        }).catchError((error) {
          DialogHelper.showErroDialog(description: error.toString());
        });
      }
    });
  }

  Future checkBookmark(String placeid) async {
    final collection = dbBookmark.doc(auth.currentUser!.email);
    final docSnap = await collection.get();
    return await collection
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        List cart = docSnap.get('place');
        List item = cart
            .where((element) => element['place_id'].contains(placeid))
            .toList();
        if (item.isEmpty) {
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    });
  }
}
