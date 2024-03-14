import 'dart:io';

import 'package:musafir/data/entities/user.dart';
import '../entities/result.dart';

abstract interface class UserRepository {
  Future<Result<User>> createUser({
    required String uid,
    required String email,
    required String firstName,
    required String lastName,
    String? photoUrl,
  });

  Future<Result<User>> getUser({required String uid});
  Future<Result<User>> updateUser({required User user});
  Future<Result<User>> uploadProfilePicture(
      {required User user, required File imageFile});
}
