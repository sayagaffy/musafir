// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';

import 'package:musafir/ui/widgets/text_field_password.dart';
import 'package:musafir/ui/widgets/text_field_text.dart';

class SignUpPage1 extends StatelessWidget {
  const SignUpPage1({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController =
        TextEditingController(text: 'developer.adhikari.1@gmail.com');

    var namaDepanController = TextEditingController();
    var namaBelakangController = TextEditingController();
    var nomorHpController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordKonfirmController = TextEditingController();

    void _registration() {
      var authController = Get.find<AuthController>();
      String nameDepan = namaDepanController.text.trim();
      String nameBelakang = namaBelakangController.text.trim();
      String phone = nomorHpController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String passwordKonfirm = passwordKonfirmController.text.trim();

      if (nameDepan.isEmpty) {
        showCustomSnackBar("Nama depan tidak boleh kosong",
            title: "Nama Depan");
      } else if (nameBelakang.isEmpty) {
        showCustomSnackBar("Nama Belakang tidak boleh kosong",
            title: "Nama Belakang");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Nomor HP tidak boleh kosong", title: "Nomot HP");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email adress", title: "Email adress");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email adress",
            title: "Valid email adress");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else if (passwordKonfirm.isEmpty) {
        showCustomSnackBar("Type in your password",
            title: "Konfirmasi Password");
      } else if (passwordKonfirm.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Konfirmasi Password");
      } else if (passwordKonfirm != password) {
        showCustomSnackBar("Konfirmasi Password Harus sama dengan Password",
            title: "Konfirmasi Password");
      } else {
        authController.signUp(
          email,
          password,
          nameDepan,
          nameBelakang,
          phone,
          passwordKonfirm,
          context,
        );
      }
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  top: 20,
                  bottom: 25,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.west_rounded,
                        size: 20,
                        color: kBlackColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Daftar',
                      style: blackTextStyle.copyWith(
                        height: 1.5,
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Silakan isi data dirimu!',
                    style: blackTextStyle.copyWith(
                      height: 1.4,
                      fontSize: 20,
                      fontWeight: extraBold,
                    ),
                  ),
                  Text(
                    'Awali petualangan kuliner di seluruh dunia.',
                    style: noColorTextStyle.copyWith(
                      height: 1.3,
                      fontSize: 12,
                      color: kNeutral70,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldText(
              textController: emailController,
              hintText: 'contoh: abe@gmailcom',
              icon: Icons.email,
              label: 'Email',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldText(
              textController: namaDepanController,
              hintText: 'contoh: Andi',
              icon: Icons.email,
              label: 'Nama Depan',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldText(
              textController: namaBelakangController,
              hintText: 'contoh: Ginting',
              icon: Icons.email,
              label: 'Nama Belakang',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldText(
              textController: nomorHpController,
              hintText: 'contoh: 081222199912',
              icon: Icons.email,
              label: 'Nomor HP',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldPassword(
              textController: passwordController,
              label: 'Kata sandi',
              hintText: 'password',
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldPassword(
              textController: passwordKonfirmController,
              label: 'Konfirmasi kata sandi',
              hintText: 'password',
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: 'Lanjut',
                  onPressed: () {
                    _registration();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Sudah punya akun ? ",
                  style: blackTextStyle.copyWith(
                    color: kGreyColor,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.toNamed(
                              RouteHelper.getsigInPage(),
                            ),
                      text: " Masuk",
                      style: noColorTextStyle.copyWith(
                        color: kBlueColor,
                        fontSize: 14,
                        fontWeight: extraBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
