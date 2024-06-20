import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
