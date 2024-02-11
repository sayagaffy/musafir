import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/controllers/users_controller.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/data/api/api_google.dart';
import 'package:musafir/data/repository/auth_repo.dart';
import 'package:musafir/data/repository/google_repo.dart';
import 'package:musafir/data/repository/users_repo.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  ///[Share Preferences ]
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstans.BASE_URL,
      sharedPreferences: Get.find<SharedPreferences>()));

  ///[Repository]
  Get.lazyPut(() => UsersRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(
      apiClient: Get.find(), sharedPreferences: Get.find<SharedPreferences>()));

  ///[Controllers]
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UsersController(usersRepo: Get.find()));

  ///[Google Client]
  Get.lazyPut(() => ApiGoogle(appBaseUrlGoogle: AppConstans.BASE_URL_GOOGLE));

  ///[Repository]
  Get.lazyPut(() => GoogleRepo(apiGoogle: Get.find()));

  ///[Controllers]
  Get.lazyPut(() => GoogleController(googleRepo: Get.find()));
}
