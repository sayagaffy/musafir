import 'package:get/get.dart';
import 'package:musafir/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiGoogle extends GetConnect {
  final String appBaseUrl;
  // final String mainUrl;
  // this.mainUrl = '&language=id&key=${AppConstants.API_GKEY}
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiGoogle({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
  }

  Future<Response> getData(String uri) async {
    print(uri);
    try {
      Response response = await get(uri);

      return response;
    } catch (e) {
      print('apainierror');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
