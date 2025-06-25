import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/explore_controller.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/controllers/main_page_controller.dart';
import 'package:musafir/controllers/report_controller.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/data/api/api_google.dart';
import 'package:musafir/data/firestore/firestore_helper.dart';
import 'package:musafir/data/firestore/place_store.dart';
import 'package:musafir/data/repository/auth_repo.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global FirestoreHelper instance
final FirestoreHelper firestoreHelper = FirestoreHelper();

Future<void> init() async {
  ///[Share Preferences ]
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstans.BASE_URL,
      sharedPreferences: Get.find<SharedPreferences>()));

  ///[Repository]
  Get.lazyPut(() => AuthRepo(
      apiClient: Get.find(), sharedPreferences: Get.find<SharedPreferences>()));

  // Initialize global FirestoreHelper
  Get.lazyPut(() => firestoreHelper);

  ///[Controllers]
  Get.lazyPut(() => MainPageController());
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PlacesStore());
  Get.lazyPut(
      () => ExploreController(googleRepo: Get.find(), placesStore: Get.find()));
  Get.lazyPut(() => LocationController(googleRepo: Get.find()));
  Get.lazyPut(() => HomeController(googleRepo: Get.find()));

  // Initialize ReportController with global FirestoreHelper
  Get.lazyPut(() => ReportController(firestoreHelper: firestoreHelper));

  ///[Google Client]
  Get.lazyPut(() => ApiGoogle(appBaseUrlGoogle: AppConstans.BASE_URL_GOOGLE));

  ///[Repository]
  Get.lazyPut(() => GoogleRepo(apiGoogle: Get.find()));

  ///[Controllers]
  Get.lazyPut(() => GoogleController(googleRepo: Get.find()));
}
