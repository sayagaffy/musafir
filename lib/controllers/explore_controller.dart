import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController implements GetxService {
  RxString placeIdX = ''.obs;
  TextEditingController searchPlace = TextEditingController();

  var itemPlans = 0.obs;

  void setTujuan(String description, String placeId) {
    placeIdX.value = placeId;
    searchPlace.text = description;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    searchPlace.dispose();
  }
}
