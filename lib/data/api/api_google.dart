import 'package:get/get.dart';

class ApiGoogle extends GetConnect implements GetxService {
  // late String token;
  final String appBaseUrlGoogle;

  ApiGoogle({required this.appBaseUrlGoogle}) {
    baseUrl = appBaseUrlGoogle;
    timeout = const Duration(seconds: 30);
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
