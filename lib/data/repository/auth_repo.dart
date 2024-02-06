import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/models/signup_body_model.dart';
import 'package:musafir/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClent apiClent;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClent, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClent.posData(
      AppConstants.REGISTRATION_URI,
      signUpBody.toJson(),
    );
  }

  Future<Response> login(String email, String phone, String password) async {
    dynamic data = jsonEncode(<String, String>{
      'email': email,
      'phone': phone,
      'password': password,
    });
    return await apiClent.posData(AppConstants.LOGIN_URI, data);
  }

  Future<String> getUserToken() async {
    // ignore: await_only_futures
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> saveUserToken(String token) async {
    apiClent.token = token;
    apiClent.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String numer, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, numer);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  bool clearShared() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClent.token = '';
    apiClent.updateHeader((''));
    return true;
  }
}
