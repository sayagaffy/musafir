// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/home_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/data/repository/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  Stream<User?> get streamAuthStatus => _auth.authStateChanges();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ignore: prefer_final_fields
  bool _isLoading = false;
  bool get isLoading => _isLoading;

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
        var homeC = Get.find<HomeController>();
        if (homeC.nearbyFood.isEmpty) {
          homeC.refreshHome();
        }

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
          await UserStore().createUser(
            username: user.email?.split('@')[0],
            provider: 'Google',
            photoURL: user.photoURL,
          );
        }

        ///[turn off loading indicator]
        Get.back(closeOverlays: true);
        Get.offNamed(RouteHelper.getInitial());
      }
    } catch (e) {
      Get.back(closeOverlays: true);
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

        await UserStore().createUser(
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
    var homeC = Get.find<HomeController>();
    Get.defaultDialog(
        title: "Logout ",
        middleText: "Apakah kamu ingin keluar ?",
        onConfirm: () async {
          final GoogleSignIn googleSignIn = GoogleSignIn();
          await googleSignIn.signOut();
          await FirebaseAuth.instance.signOut();
          homeC.clearList();
          Get.back();
          Get.offNamed(RouteHelper.getsigInPage());
        },
        textConfirm: "Sign out",
        textCancel: "Cancel",
        radius: 4,
        contentPadding: const EdgeInsets.only(bottom: 20),
        buttonColor: kBlueColor);
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
