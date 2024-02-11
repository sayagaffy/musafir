import 'package:get/get.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;

  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.appBaseUrl, required sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);

    token = sharedPreferences.getString(AppConstans.TOKEN) ?? "";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer  $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer  $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      print(uri.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> posData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      print(uri.toString());
      print(body.toString());
      return response;
    } catch (e) {
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
