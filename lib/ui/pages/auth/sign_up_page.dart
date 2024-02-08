import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';
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
              child: CustomButton(title: 'Sign UP', onPressed: () {}),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: "Have an Account Alredy ?",
                style: blackTextStyle.copyWith(
                  color: kGreyColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
