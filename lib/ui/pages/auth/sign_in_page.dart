// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:musafir/base/custom_loader.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/custom_button_sosial.dart';
import 'package:musafir/ui/widgets/text_field_password.dart';
import 'package:musafir/ui/widgets/text_field_text.dart';

class SignInPage1 extends StatefulWidget {
  const SignInPage1({super.key});

  @override
  State<SignInPage1> createState() => _SignInPage1State();
}

class _SignInPage1State extends State<SignInPage1> {
  @override
  void initState() {
    var locationC = Get.find<LocationController>();
    locationC.determinePosition();
    super.initState();
  }

  var emailController =
      TextEditingController(text: 'developer.adhikari.1@gmail.com');
  var passwordController = TextEditingController(text: 'qwerty');

  // ignore: no_leading_underscores_for_local_identifiers
  void _login(AuthController _authController, context) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (password.isEmpty) {
      showCustomSnackBar("type in your password", title: 'Password');
    } else if (email.isEmpty) {
      showCustomSnackBar("type in your email address", title: 'Email Address');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("type in a valid email address",
          title: 'Valid email address');
    } else if (password.length < 6) {
      showCustomSnackBar("Password can not  be less  than six characters",
          title: 'Password');
    } else {
      _authController.logins(email, password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
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
                                'Masuk',
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
                              'Assalamualaikum!',
                              style: blackTextStyle.copyWith(
                                height: 1.4,
                                fontSize: 20,
                                fontWeight: extraBold,
                              ),
                            ),
                            Text(
                              'Yuk, lanjutin jelajah kuliner halal tujuanmu.',
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
                        height: 15,
                      ),
                      TextFieldPassword(
                        textController: passwordController,
                        label: 'Password',
                        hintText: 'password',
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(RouteHelper.getResetPasswordPage());
                          },
                          child: Text(
                            'lupa kata sandi ?',
                            style: greyTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            title: 'Masuk',
                            onPressed: () {
                              _login(authController, context);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 18.0,
                                  right: 18,
                                ),
                                child: Divider(
                                  color: kNeutral70,
                                  height: 36,
                                ),
                              ),
                            ),
                            Text(
                              'atau masuk dengan',
                              style: noColorTextStyle.copyWith(
                                color: kNeutral70,
                                fontSize: 12,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 18.0,
                                  right: 18,
                                ),
                                child: Divider(
                                  color: kNeutral70,
                                  height: 36,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            CustomButtonSosial(
                              title: 'Masuk lewat Google',
                              onPressed: () {
                                var authController = Get.find<AuthController>();
                                authController.signInWithGoogle(context);
                              },
                              icon: "assets/icon_google.png",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomButtonSosial(
                              title: 'Masuk lewat Facebook',
                              onPressed: () {
                                var authController = Get.find<AuthController>();
                                authController.signInWithFacebook();
                              },
                              icon: "assets/icon_facebook.png",
                            ),
                            // const SizedBox(
                            //   height: 15,
                            // ),
                            // CustomButtonSosial(
                            //   title: 'Masuk lewat Apple',
                            //   onPressed: () {},
                            //   icon: "assets/icon_apple.png",
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Belum punya akun ? ",
                            style: blackTextStyle.copyWith(
                              color: kGreyColor,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(
                                        () => const SignUpPage1(),
                                        duration:
                                            const Duration(milliseconds: 300),
                                      ),
                                text: " Daftar",
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
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
