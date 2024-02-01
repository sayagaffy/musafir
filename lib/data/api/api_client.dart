import 'package:get/get.dart';
import 'package:musafir/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClent extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;

  late SharedPreferences sharedPreferences;

  late Map<String, String> _mainHeaders;
  ApiClent({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    // token = AppConstants.TOKEN;
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? "";
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

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> posData(String uri, dynamic body) async {
    try {
      Response response = await post(uri, body, headers: _mainHeaders);
      // ignore: avoid_print
      print(response.toString());
      return response;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      // ignore: avoid_print
      print(e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
