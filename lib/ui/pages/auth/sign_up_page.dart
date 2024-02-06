import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/custom_loader.dart';
import 'package:musafir/base/show_custom_snack_bar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/models/signup_body_model.dart';
import 'package:musafir/routes/router_helper.dart';

import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/auth/sign_in_page.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/text_field_custom.dart';

class SignUpPage1 extends StatelessWidget {
  const SignUpPage1({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneContoller = TextEditingController();

    // ignore: no_leading_underscores_for_local_identifiers
    void _registration(AuthController _authController) {
      // var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneContoller.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("type in your name", title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar("type in your phone number", title: 'Phone Number');
      } else if (password.isEmpty) {
        showCustomSnackBar("type in your password", title: 'Password');
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
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        _authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar("Register Successfuly ",
                title: 'Perfect', backgroundColor: Colors.green);
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      // ignore: no_leading_underscores_for_local_identifiers
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80),
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
                    TextFieldCustom(
                      textController: emailController,
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                    TextFieldCustom(
                      textController: passwordController,
                      hintText: 'Password',
                      icon: Icons.password_rounded,
                    ),
                    TextFieldCustom(
                      textController: nameController,
                      hintText: 'Name',
                      icon: Icons.phone_android_rounded,
                    ),
                    TextFieldCustom(
                      textController: phoneContoller,
                      hintText: 'Phone',
                      icon: Icons.person_rounded,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 200,
                      child: CustomButton(
                        title: 'Sign up',
                        onPressed: () {
                          _registration(_authController);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(
                                () => const SignInPage1(),
                                transition: Transition.fade,
                                duration: const Duration(milliseconds: 300),
                              ),
                        text: "Have an Account Alredy ?",
                        style: blackTextStyle.copyWith(
                          color: kGreyColor,
                          fontSize: 14,
                        ),
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
