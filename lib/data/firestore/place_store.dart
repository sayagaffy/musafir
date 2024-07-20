import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:musafir/base/dialog_helper.dart';

import 'package:musafir/shared/theme.dart';

class PlacesStore {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // collection reference
  final CollectionReference dbPlaces =
      FirebaseFirestore.instance.collection('places');

  Future placesList(int countryId, int cityId) async {
    dynamic review;

    await dbPlaces
        .where("country_id", isEqualTo: countryId)
        .where("city_id", isEqualTo: cityId)
        .get()
        .then(
          (QuerySnapshot querySnapshot) => {review = querySnapshot},
          onError: (e) => print("Error completing: $e"),
        );

    return review;
  }

  Future placesListWhere(int countryId, int cityId, int halalstatus) async {
    dynamic review;

    await dbPlaces
        .where("country_id", isEqualTo: countryId)
        .where("city_id", isEqualTo: cityId)
        .where("halal_status", isEqualTo: halalstatus)
        .get()
        .then(
          (QuerySnapshot querySnapshot) => {
            review = querySnapshot
            // for (var element in querySnapshot.docs) { return element.data()},
          },
          onError: (e) => print("Error completing: $e"),
        );
    return review;
  }

  Future checkPlaces(String placeid) async {
    dynamic review;

    return await dbPlaces.where("place_id", isEqualTo: placeid).get().then(
      (value) {
        return value.docs.length;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future placesId() async {
    List place = [];

    await dbPlaces.orderBy('id').get().then(
      (value) {
        for (var i in value.docs) {
          place.add(i.data());
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return place.last;
  }

  Future addPlaceToInternal(payload) async {
    DialogHelper.showLoading('Add New Place..');

    return await dbPlaces.doc().set(payload).then((value) {
      DialogHelper.hideLoading();

      DialogHelper.showSnackBar(
        'Berhasil Menambahkan Place ke Database',
        title: 'Successfuly',
        backgroundColor: kSuccessMain,
      );

      return 'SUCCESS';
    }).catchError((error) {
      DialogHelper.hideLoading();
      DialogHelper.showErroDialog(description: error.toString());

      return 'Error';
    });
  }
}
