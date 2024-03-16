import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/text_field_custom.dart';

class SignUpPage1 extends StatelessWidget {
  const SignUpPage1({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController(text: 'testlog@gmail.com');
    var passwordController = TextEditingController(text: 'qwerty');
    // var nameController = TextEditingController();
    // var phoneController = TextEditingController();

    // ignore: no_leading_underscores_for_local_identifiers
    void _registration() {
      var authController = Get.find<AuthController>();
      // String name = nameController.text.trim();
      // String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // if (name.isEmpty) {
      //   showCustomSnackBar("Type in your name", title: "Name");
      // } else if (phone.isEmpty) {
      //   showCustomSnackBar("Type in phone name", title: "Phone numer");
      // }
      if (email.isEmpty) {
        showCustomSnackBar("Type in your email adress", title: "Email adress");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email adress",
            title: "Valid email adress");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        // SignUpBody signUpBody = SignUpBody(
        //   // name: name,
        //   // phone: phone,
        //   email: email,
        //   password: password,
        // );

        // authController.registration(signUpBody).then((status) {
        //   if (status.isSuccess) {
        //     showCustomSnackBar('Success Registrasi',
        //         title: 'Success', backgroundColor: kBlueColor);
        //     Get.offNamed(RouteHelper.getInitial());
        //   } else {
        //     showCustomSnackBar(status.message);
        //   }
        // });
        authController.signUp(email, password);
      }
    }

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
            // TextFieldCustom(
            //   textController: nameController,
            //   hintText: 'Name',
            //   icon: Icons.phone_android_rounded,
            // ),
            // TextFieldCustom(
            //   textController: phoneController,
            //   hintText: 'Phone',
            //   icon: Icons.person_rounded,
            // ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 200,
              child: CustomButton(
                  title: 'Sign up',
                  onPressed: () {
                    _registration();
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getsigInPage());
              },
              child: Text(
                "Have an Account Alredy ?",
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
