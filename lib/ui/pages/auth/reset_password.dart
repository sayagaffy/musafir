// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:musafir/base/custom_loader.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/text_field_custom.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  // ignore: override_on_non_overriding_member
  var emailController = TextEditingController(text: 'testlog@gmail.com');

  // ignore: no_leading_underscores_for_local_identifiers
  void _reset(AuthController _authController) {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar("type in your email address", title: 'Email Address');
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("type in a valid email address",
          title: 'Valid email address');
    } else {
      _authController.resetPassword(email);
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
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 70),
                        child: Center(
                          child: ClipOval(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                'assets/icon_musafir_icon.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.contain,
                                color: kBlackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Reset your password login',
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldCustom(
                        textController: emailController,
                        hintText: 'Email',
                        icon: Icons.email,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: 200,
                        child: CustomButton(
                            title: 'Reset Password',
                            onPressed: () {
                              _reset(authController);
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "have an Account ? ",
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
                              text: " Sign In",
                              style: blackTextStyle.copyWith(
                                  color: kBlackColor,
                                  fontSize: 14,
                                  fontWeight: extraBold),
                            )
                          ],
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
