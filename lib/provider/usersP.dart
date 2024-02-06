import 'package:get/get.dart';

class UserProvider extends GetConnect {
  //get request
  Future<Response> getUser(int id) =>
      get('https://jsonplaceholder.typicode.com/users?id=${id}');
}
