import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:musafir/data/entities/result.dart';
import 'package:musafir/data/entities/user.dart';
import 'package:musafir/data/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:musafir/data/usecases/login/login.dart';
import 'package:musafir/data/usecases/register/register.dart';
import 'package:musafir/data/usecases/register/register_param.dart';
import 'package:musafir/data/usecases/upload_profile_picture/upload_profile_picture.dart';
import 'package:musafir/data/usecases/upload_profile_picture/upload_profile_picture_params.dart';
import 'package:musafir/presentation/providers/usecases/get_logged_in_user/get_logged_in_user_provider.dart';
import 'package:musafir/presentation/providers/usecases/login/login_provider.dart';
import 'package:musafir/presentation/providers/usecases/logout/logout_provider.dart';
import 'package:musafir/presentation/providers/usecases/register/register_provider.dart';
import 'package:musafir/presentation/providers/usecases/upload_profile_picture/upload_profile_picture_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      String? imageUrl}) async {
    state = const AsyncLoading();

    Register register = ref.read(registerProvider);

    var result = await register(RegisterParam(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        photoUrl: imageUrl));

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var result = await getLoggedInUser(null);
    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);
    var result = await uploadProfilePicture(
        UploadProfilePictureParam(imageFile: imageFile, user: user));
    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }
}
