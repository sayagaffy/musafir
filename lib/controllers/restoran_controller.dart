import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class RestoranController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRestoran(String name, String address, LatLng? location,
      String? halalStatus, String operationalHours, XFile? image) async {
    CollectionReference restorans = _firestore.collection('restorans');
    await restorans.add({
      'name': name,
      'address': address,
      'location': location != null
          ? GeoPoint(location.latitude, location.longitude)
          : null,
      'halalStatus': halalStatus,
      'operationalHours': operationalHours,
      'imagePath': image?.path,
    }).then((_) {
      Get.snackbar('Success', 'Restoran Added');
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to add restoran: $error');
    });
  }
}
