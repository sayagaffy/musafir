import 'package:get/get.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/utils/app_constants.dart';

class UserRepo {
  final ApiClent apiClent;
  UserRepo({required this.apiClent});

  Future<Response> getUserInfo() async {
    return await apiClent.getData(AppConstants.USER_INFO_URI);
  }
}
