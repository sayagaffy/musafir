import 'package:get/get.dart';
import 'package:musafir/data/repository/users_repo.dart';

class UsersController extends GetxController {
  final UsersRepo usersRepo;

  UsersController({required this.usersRepo});
  List<dynamic> _usersList = [];

  List<dynamic> get usersList => _usersList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getUsersList() async {
    Response response = await usersRepo.getUsersList();

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(response.body);
      _usersList = [];
      // _usersList.addAll(Users.fromJson(response.body).data);
      // print(_usersList);

      _isLoaded = true;
      update();
    }
  }
}
