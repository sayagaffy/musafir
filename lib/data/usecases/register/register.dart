import 'package:musafir/data/entities/result.dart';
import 'package:musafir/data/entities/user.dart';
import 'package:musafir/data/repositories/authentication.dart';
import 'package:musafir/data/repositories/user_repository.dart';
import 'package:musafir/data/usecases/register/register_param.dart';
import 'package:musafir/data/usecases/usecase.dart';

class Register implements UseCase<Result<User>, RegisterParam> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  Register(
      {required Authentication authentication,
      required UserRepository userRepository})
      : _authentication = authentication,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(RegisterParam params) async {
    var uidResult = await _authentication.register(
        email: params.email, password: params.password);
    if (uidResult.isSuccess) {
      var userResult = await _userRepository.createUser(
          uid: uidResult.resultValue!,
          email: params.email,
          firstName: params.firstName,
          lastName: params.lastName,
          photoUrl: params.photoUrl);
      if (userResult.isSuccess) {
        return Result.success(userResult.resultValue!);
      } else {
        return Result.failed(userResult.errorMessage!);
      }
    } else {
      return Result.failed(uidResult.errorMessage!);
    }
  }
}
