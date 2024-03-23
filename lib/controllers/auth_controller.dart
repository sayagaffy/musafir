// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/data/firestore/users.dart';
import 'package:musafir/data/repository/auth_repo.dart';
import 'package:musafir/models/response_model.dart';
import 'package:musafir/models/signup_body_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    // print("Getting token");
    // authRepo.getUserToken();
    // print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      // print("Backend token");
      authRepo.saveUserToken(response.body["token"]);
      // print(response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void svaeUserNumerNadPassword(String numer, String password) {
    authRepo.svaeUserNumerNadPassword(numer, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedDate() {
    return authRepo.clearShared();
  }

  void showLoading(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: CircularProgressIndicator(
          color: kBlueColor,
        ));
      },
    );
  }

  void logins(
      String emailAddress, String password, BuildContext context) async {
    try {
      showLoading(context);

      UserCredential myUser = await _auth.signInWithEmailAndPassword(
        email: emailAddress.toString(),
        password: password.toString(),
      );
      if (myUser.user!.emailVerified) {
        var homeController = Get.find<HomeController>();
        homeController.refreshHome();

        ///[turn off loading indicator]
        Get.back(closeOverlays: true);
        Get.offNamed(RouteHelper.getInitial());
      } else {
        ///[turn off loading indicator]
        Get.back(closeOverlays: true);
        Get.defaultDialog(
          title: "Verifikasi Email",
          middleText:
              "kamu perlu verifikasi email terlebih dahulu. Apakah kamu mau dikirimkan vertifikasi ulang ?",
          onConfirm: () async {
            await myUser.user!.sendEmailVerification();
            Get.back();
          },
          textConfirm: "kirim ulang",
          textCancel: "kembali",
        );
      }
    } on FirebaseAuthException catch (e) {
      ///[turn off loading indicator]
      Get.back(closeOverlays: true);

      //Show message
      if (e.code == 'user-not-found') {
        showCustomSnackBar("No user found for that email.",
            title: 'gagal untuk masuk');
      } else if (e.code == 'wrong-password') {
        showCustomSnackBar("Wrong password provided for that user.",
            title: 'gagal untuk masuk');
      } else if (e.code == 'invalid-credential') {
        showCustomSnackBar("User tidak di temukan", title: 'gagal untuk masuk');
      } else {
        showCustomSnackBar(e.code, title: 'Gagal untuk masuk');
      }
    }
  }

  void signInWithGoogle(context) async {
    try {
      showLoading(context);
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await DbUsers().createUser(
            userCredential.user!.email.toString(),
            username: user.email?.split('@')[0],
            provider: 'Google',
            photoURL: user.photoURL,
          );
        }
        var homeController = Get.find<HomeController>();
        homeController.refreshHome();

        ///[turn off loading indicator]
        Get.back(closeOverlays: true);
        Get.offNamed(RouteHelper.getInitial());
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  void signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          //Save user if new
          await DbUsers().createUser(
            user.email.toString(),
            username: user.email?.split('@')[0],
            provider: 'facebook',
          );
        }

        Get.offNamed(RouteHelper.getInitial());
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  void signUp(
    String emailAddress,
    String password,
    String namaDepan,
    String namaBelakang,
    String phone,
    context,
  ) async {
    try {
      showLoading(context);

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      ///[turn off loading indicator]
      Get.back(closeOverlays: true);

      if (userCredential.additionalUserInfo!.isNewUser) {
        //Save user if new
        await DbUsers().createUser(
          userCredential.user!.email.toString(),
          username: emailAddress.split('@')[0],
          firstName: namaDepan,
          lastName: namaBelakang,
          phone: phone,
          provider: 'email',
        );

        //Send email verivication
        await userCredential.user!.sendEmailVerification();

        showCustomSnackBar(
          'Kami telah mengirimkan email verifikasi ke $emailAddress . ',
          isError: false,
          title: 'Success Registrasi',
          backgroundColor: kSuccessMain,
        );
      }
    } on FirebaseAuthException catch (e) {
      ///[turn off loading indicator]
      Get.back(closeOverlays: true);

      //show message error
      if (e.code == 'weak-password') {
        showCustomSnackBar('the password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showCustomSnackBar('The account already exists for that email');
      } else {
        showCustomSnackBar(e.code);
      }
    } catch (e) {
      print(e);
    }
  }

  void logout() async {
    Get.defaultDialog(
      title: "Logout ",
      middleText: "Apakah kamu ingin keluar ?",
      onConfirm: () async {
        await FirebaseAuth.instance.signOut();
        Get.back();
        Get.offNamed(RouteHelper.getsigInPage());
      },
      textConfirm: "Sign out",
      textCancel: "Cancel",
    );
  }

  void resetPassword(String emailAddress, context) async {
    try {
      showLoading(context);
      await _auth.sendPasswordResetEmail(email: emailAddress);

      ///[turn off loading indicator]
      Get.back(closeOverlays: true);

      showCustomSnackBar(
        'Kami telah mengirimkan reset password ke $emailAddress . ',
        isError: false,
        title: 'Success Reset Password',
        backgroundColor: kSuccessMain,
      );
    } catch (e) {
      ///[turn off loading indicator]
      Get.back(closeOverlays: true);

      showCustomSnackBar(
        "Terjadi kesalahan, tidak dapat mengirimkan reset password",
      );
      print(e);
    }
  }
}
