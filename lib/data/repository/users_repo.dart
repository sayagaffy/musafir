import 'package:get/get.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/utilitis/apps_constants.dart';

class UsersRepo extends GetxService {
  final ApiClient apiClient;
  UsersRepo({required this.apiClient});

  Future<Response> getUsersList() async {
    return await apiClient.getData(AppConstans.USERS_LIST);
  }
}
