import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/controllers/user_controller.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/data/api/api_google.dart';
import 'package:musafir/data/repository/auth_repo.dart';
import 'package:musafir/data/repository/location_repo.dart';
import 'package:musafir/data/repository/user_repo.dart';
import 'package:musafir/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(
    () => ApiGoogle(appBaseUrl: AppConstants.BASE_URL_GOOGLE),
  );

  // api client
  Get.lazyPut(
    () => ApiClent(
        appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()),
  );

  Get.lazyPut(
    () => AuthRepo(apiClent: Get.find(), sharedPreferences: Get.find()),
  );
  Get.lazyPut(
    () => UserRepo(apiClent: Get.find()),
  );

  //repos
  Get.lazyPut(
    () => LocationRepo(apiGoogle: Get.find(), sharedPreferences: Get.find()),
  );

  //controller
  Get.lazyPut(
    () => AuthController(authRepo: Get.find()),
  );
  Get.lazyPut(
    () => UserController(userRepo: Get.find()),
  );
  Get.lazyPut(
    () => LocationController(locationRepo: Get.find()),
  );
}
