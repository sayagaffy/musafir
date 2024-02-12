import 'dart:convert';

import 'package:get/get.dart';
import 'package:musafir/data/api/api_client.dart';
import 'package:musafir/models/signup_body_model.dart';
import 'package:musafir/utilitis/apps_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.posData(
        AppConstans.REGISTRATION_URI, signUpBody.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstans.TOKEN);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstans.TOKEN) ?? "None";
  }

  Future<Response> login(String email, String password) async {
    dynamic data = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });
    return await apiClient.posData(AppConstans.LOGIN_URI, data);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstans.TOKEN, token);
  }

  Future<void> svaeUserNumerNadPassword(String numer, String password) async {
    try {
      await sharedPreferences.setString(AppConstans.PHONE, numer);
      await sharedPreferences.setString(AppConstans.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearShared() {
    sharedPreferences.remove(AppConstans.TOKEN);
    sharedPreferences.remove(AppConstans.PASSWORD);
    sharedPreferences.remove(AppConstans.PHONE);
    apiClient.token = '';
    apiClient.updateHeader((''));
    return true;
  }
}
