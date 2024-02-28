import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:musafir/base/custom_loader.dart';
import 'package:musafir/base/show_custom_snackbar.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/google_controller.dart';
import 'package:musafir/controllers/location_controller.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import 'package:musafir/ui/widgets/custom_button.dart';
import 'package:musafir/ui/widgets/text_field_custom.dart';

class SignInPage1 extends StatefulWidget {
  const SignInPage1({super.key});

  @override
  State<SignInPage1> createState() => _SignInPage1State();
}

class _SignInPage1State extends State<SignInPage1> {
  @override
  void initState() {
    var locationController = Get.find<LocationController>();
    locationController.startedPosition();
    super.initState();
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // ignore: no_leading_underscores_for_local_identifiers
  void _login(AuthController _authController) {
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
      // _authController.login(email, password).then((status) {
      //   if (status.isSuccess) {
      //     Get.toNamed(RouteHelper.getInitial());
      //   } else {
      //     showCustomSnackBar(status.message);
      //   }
      // });

      var googleControllers = Get.find<GoogleController>();
      var locationController = Get.find<LocationController>();

      String latLang =
          '${locationController.latlng?.latitude}, ${locationController.latlng?.longitude}';

      if (googleControllers.isLoadedFood == false) {
        googleControllers.getNearbyPlace(
          keyword: 'food',
          rankby: 'distance',
          type: 'restaurant',
          location: latLang,
        );
      }

      if (googleControllers.isLoadedMosque == false) {
        googleControllers.getNearbyPlace(
          keyword: 'masjid',
          rankby: 'distance',
          type: 'mosque',
          location: latLang,
        );
      }

      Get.toNamed(RouteHelper.getInitial());
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
                        child: CustomButton(
                            title: 'Sign in',
                            onPressed: () {
                              _login(authController);
                            }),
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
                                        duration:
                                            const Duration(milliseconds: 300),
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
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
