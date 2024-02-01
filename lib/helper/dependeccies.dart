import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/data/repository/location_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //repos
  Get.lazyPut(
      () => LocationRepo(apiClent: Get.find(), sharedPreferences: Get.find()));

  //controller
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
