import 'package:musafir/data/entities/result.dart';
import 'package:musafir/data/repositories/authentication.dart';
import 'package:musafir/data/usecases/usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final Authentication _authentication;

  Logout({required Authentication authentication})
      : _authentication = authentication;
  @override
  Future<Result<void>> call(void _) {
    return _authentication.logout();
  }
}
