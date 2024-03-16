// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
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

  void logins(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: emailAddress.toString(),
        password: password.toString(),
      );
      if (myUser.user!.emailVerified) {
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

  void signUp(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await myUser.user!.sendEmailVerification();

      showCustomSnackBar(
        'Kami telah mengirimkan email verifikasi ke $emailAddress . ',
        isError: false,
        title: 'Success Registrasi',
        backgroundColor: kSuccessMain,
      );
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
    await FirebaseAuth.instance.signOut();
    Get.offNamed(RouteHelper.getsigInPage());
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
