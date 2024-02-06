import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/base/custom_loader.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/user_controller.dart';
import 'package:musafir/routes/router_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/account_widget.dart';
import 'package:musafir/ui/widgets/app_icon.dart';
import 'package:musafir/ui/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print('user has logind');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: BigText(
              text: 'Account Profile',
              size: 20,
              color: kBlackColor,
            ),
          ),
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const AppIcon(
                            icon: Icons.person_2_rounded,
                            size: 50,
                            iconSize: 39,
                            backgroundColor: Color.fromARGB(255, 14, 108, 195),
                            iconColor: Color(0xFFFFFFFF),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          AccountWidget(
                            appIcon: const AppIcon(
                              icon: Icons.person,
                              size: 35,
                              iconSize: 20,
                              iconColor: Color(0xFFFFFFFF),
                            ),
                            bigText: BigText(
                              text: userController.userModel.name,
                              size: 15,
                            ),
                          ),
                          AccountWidget(
                            appIcon: const AppIcon(
                              icon: Icons.phone,
                              size: 35,
                              iconSize: 20,
                              backgroundColor: Color(0xff0EC3AE),
                              iconColor: Color(0xFFFFFFFF),
                            ),
                            bigText: BigText(
                              text: userController.userModel.phone,
                              size: 15,
                            ),
                          ),
                          AccountWidget(
                            appIcon: const AppIcon(
                              icon: Icons.email,
                              size: 35,
                              iconSize: 20,
                              backgroundColor:
                                  Color.fromARGB(255, 14, 108, 195),
                              iconColor: Color(0xFFFFFFFF),
                            ),
                            bigText: BigText(
                              text: userController.userModel.email,
                              size: 15,
                            ),
                          ),
                          const AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.location_on,
                              size: 35,
                              iconSize: 20,
                              backgroundColor: Color.fromARGB(255, 68, 195, 14),
                              iconColor: Color(0xFFFFFFFF),
                            ),
                            bigText: BigText(
                              text: 'Address',
                              size: 15,
                            ),
                          ),
                          const AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.email,
                              size: 35,
                              iconSize: 20,
                              backgroundColor:
                                  Color.fromARGB(255, 195, 14, 162),
                              iconColor: Color(0xFFFFFFFF),
                            ),
                            bigText: BigText(
                              text: 'Message',
                              size: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>()
                                  .authRepo
                                  .userLoggedIn()) {
                                Get.find<AuthController>()
                                    .authRepo
                                    .clearShared();
                              }
                              Get.offNamed(RouteHelper.getsigInPage());
                            },
                            child: const AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.logout_rounded,
                                size: 35,
                                iconSize: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 195, 14, 14),
                                iconColor: Color(0xFFFFFFFF),
                              ),
                              bigText: BigText(
                                text: 'Logout',
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const CustomLoader())
            : Center(
                child: Text(
                'You must login',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                ),
              ));
      }),
    );
  }
}
