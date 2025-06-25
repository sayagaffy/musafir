import 'package:get/get.dart';

class MainPageController extends GetxController implements GetxService {
  RxInt menuTabController = 0.obs;

  // Tab indices for new 3-tab structure
  static const int homeTab = 0;
  static const int itineraryTab = 1; // Formerly explore
  static const int accountTab = 2; // Changed from index 3 to 2

  // Validate tab index (0-2 instead of 0-3)
  void setTab(int index) {
    if (index >= 0 && index <= 2) {
      menuTabController.value = index;
    } else {
      menuTabController.value = homeTab; // Fallback to home
    }
  }
}
