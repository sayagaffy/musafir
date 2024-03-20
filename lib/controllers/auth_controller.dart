// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
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

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

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

  void getGoogleApi() {
    var homeController = Get.find<HomeController>();

    var locationController = Get.find<LocationController>();

    String latLang =
        '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}';

    if (homeController.isLoadedFood == false) {
      homeController.getNearbyPlace(
        keyword: 'food',
        rankby: 'distance',
        type: 'restaurant',
        location: latLang,
      );
    }

    if (homeController.isLoadedMosque == false) {
      homeController.getNearbyPlace(
        keyword: 'masjid',
        rankby: 'distance',
        type: 'mosque',
        location: latLang,
      );
    }
  }

  void logins(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: emailAddress.toString(),
        password: password.toString(),
      );
      if (myUser.user!.emailVerified) {
        getGoogleApi();
        Get.offNamed(RouteHelper.getInitial());
      } else {
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
      if (e.code == 'user-not-found') {
        showCustomSnackBar("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showCustomSnackBar("Wrong password provided for that user.");
      } else {
        showCustomSnackBar(e.code);
      }
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          firestore.collection("users").doc(user.email).set({
            'username': user.email?.split('@')[0],
            'bio': 'empty bio..',
            'profilePhoto': user.photoURL,
            'namaDepan': '',
            'namaBelakang': '',
            'phone': '',
            'provider': 'Google',
            'address': '',
            'latlang': ''
          });
        }
        getGoogleApi();
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
          await auth.signInWithCredential(facebookAuthCredential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          firestore.collection("users").doc(user.email).set({
            'username': user.email?.split('@')[0],
            'bio': 'empty bio..',
            'profilePhoto': user.photoURL,
            'namaDepan': '',
            'namaBelakang': '',
            'phone': '',
            'provider': 'facebook',
            'address': '',
            'latlang': ''
          });
        }

        Get.offNamed(RouteHelper.getInitial());
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  void signUp(String emailAddress, String password, String namaDepan,
      String namaBelakang, String phone, String passwordKonfrim) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (userCredential.additionalUserInfo!.isNewUser) {
        firestore.collection("users").doc(userCredential.user!.email).set({
          'username': emailAddress.split('@')[0],
          'bio': 'empty bio..',
          'profilePhoto': 'none',
          'namaDepan': namaDepan,
          'namaBelakang': namaBelakang,
          'phone': phone,
          'provider': 'email',
          'address': '',
          'latlang': ''
        });

        await userCredential.user!.sendEmailVerification();
        showCustomSnackBar(
          'Kami telah mengirimkan email verifikasi ke $emailAddress . ',
          isError: false,
          title: 'Success Registrasi',
          backgroundColor: kSuccessMain,
        );
      }
    } on FirebaseAuthException catch (e) {
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

  void resetPassword(String emailAddress) async {
    try {
      await auth.sendPasswordResetEmail(email: emailAddress);

      showCustomSnackBar(
        'Kami telah mengirimkan reset password ke $emailAddress . ',
        isError: false,
        title: 'Success Reset Password',
        backgroundColor: kSuccessMain,
      );
    } catch (e) {
      showCustomSnackBar(
        "Terjadi kesalahan, tidak dapat mengirimkan reset password",
      );
      print(e);
    }
  }
}
