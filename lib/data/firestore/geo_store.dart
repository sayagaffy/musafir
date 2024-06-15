import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeoStore {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // collection reference
  final CollectionReference dbCity =
      FirebaseFirestore.instance.collection('city_List');
  final CollectionReference dbProvince =
      FirebaseFirestore.instance.collection('province_list');
  final CollectionReference dbCountry =
      FirebaseFirestore.instance.collection('country_list');

  Future placesCountry(String iso) async {
    dynamic country;

    await dbCountry.where("iso", isEqualTo: iso).get().then(
          (QuerySnapshot querySnapshot) => {
            country = querySnapshot
            // for (var element in querySnapshot.docs) { return element.data()},
          },
          onError: (e) => print("Error completing: $e"),
        );
    return country;
  }

  Future placesProvince(String provinsi) async {
    dynamic province;

    await dbProvince.where("name", isEqualTo: provinsi).get().then(
          (QuerySnapshot querySnapshot) => {
            province = querySnapshot
            // for (var element in querySnapshot.docs) { return element.data()},
          },
          onError: (e) => print("Error completing: $e"),
        );
    return province;
  }

  Future placesCity(String cty) async {
    dynamic city;

    await dbCity.where("name", isEqualTo: cty).get().then(
          (QuerySnapshot querySnapshot) => {
            city = querySnapshot
            // for (var element in querySnapshot.docs) { return element.data()},
          },
          onError: (e) => print("Error completing: $e"),
        );
    return city;
  }
}
