import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  await insertDataToFirestore();
}

Future<void> insertDataToFirestore() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> countries = [];

  List<Map<String, dynamic>> provinces = [];

  List<Map<String, dynamic>> cities = [];

  // Insert Countries
  for (var country in countries) {
    await firestore.collection("countries").doc(country['id']).set({
      "id": country['id'],
      "iso": country['iso'],
      "name": country['name'],
    });
  }

  // Insert Provinces
  for (var province in provinces) {
    await firestore
        .collection("countries")
        .doc(province['country_id'])
        .collection("provinces")
        .doc(province['id'])
        .set({
      "id": province['id'],
      "name": province['name'],
    });
  }

  // Insert Cities
  for (var city in cities) {
    await firestore
        .collection("countries")
        .doc(getCountryIdForProvince(provinces, city['province_id']))
        .collection("provinces")
        .doc(city['province_id'])
        .collection("cities")
        .doc(city['id'])
        .set({
      "id": city['id'],
      "name": city['name'],
    });
  }

  debugPrint("Data successfully uploaded to Firestore!");
}

String getCountryIdForProvince(
    List<Map<String, dynamic>> provinces, String provinceId) {
  var province =
      provinces.firstWhere((p) => p['id'] == provinceId, orElse: () => {});
  return province.isNotEmpty ? province['country_id'] : "";
}
