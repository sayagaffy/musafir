import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
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
              textController: passwordController,
              hintText: 'Password',
              icon: Icons.password_rounded,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              child: CustomButton(title: 'Sign in', onPressed: () {}),
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
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            ),
                      text: " Create",
                      style: blackTextStyle.copyWith(
                          color: kBlackColor,
                          fontSize: 14,
                          fontWeight: extraBold),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
