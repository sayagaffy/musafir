import 'dart:io';

import 'package:musafir/data/entities/result.dart';
import 'package:musafir/data/entities/user.dart';
import 'package:musafir/data/repositories/user_repository.dart';

class DummyUserRepository implements UserRepository {
  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String firstName,
      required String lastName,
      String? photoUrl}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    await Future.delayed(const Duration(seconds: 1));
    return Result.success(User(
        uid: uid,
        email: 'dummy@dummy.com',
        firstName: 'dummy',
        lastName: 'billy'));
  }

  @override
  Future<Result<User>> updateUser({required User user}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> uploadProfilePicture(
      {required User user, required File imageFile}) {
    throw UnimplementedError();
  }
}
