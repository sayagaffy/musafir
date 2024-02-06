import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/custom_loader.dart';
import 'package:musafir/base/show_custom_snack_bar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/routes/router_helper.dart';

import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';

import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/text_field_custom.dart';

class SignInPage1 extends StatelessWidget {
  const SignInPage1({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    // ignore: no_leading_underscores_for_local_identifiers
    void _login(AuthController _authController) {
      // var authController = Get.find<AuthController>();

      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (password.isEmpty) {
        showCustomSnackBar("type in your password", title: 'Password');
      } else if (phone.isEmpty) {
        showCustomSnackBar("type in your phone number", title: 'Phone Number');
      } else if (email.isEmpty) {
        showCustomSnackBar("type in your email address",
            title: 'Email Address');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("type in a valid email address",
            title: 'Valid email address');
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not  be less  than six characters",
            title: 'Password');
      } else {
        _authController.login(email, phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            print('success Login');
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: GetBuilder<AuthController>(builder: (authController) {
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
                      'Sign into your account',
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
                    TextFieldCustom(
                      textController: phoneController,
                      hintText: 'Phone',
                      icon: Icons.phone_rounded,
                    ),
                    TextFieldCustom(
                      textController: passwordController,
                      hintText: 'Password',
                      icon: Icons.password_rounded,
                      isObscure: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 200,
                      child: CustomButton(
                        title: 'Sign in',
                        onPressed: () {
                          _login(authController);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an Account ? ",
                        style: blackTextStyle.copyWith(
                          color: kGreyColor,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(
                                    () => const SignUpPage1(),
                                    transition: Transition.fade,
                                    duration: const Duration(milliseconds: 300),
                                  ),
                            text: " Create",
                            style: blackTextStyle.copyWith(
                              color: kBlackColor,
                              fontSize: 14,
                              fontWeight: extraBold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
