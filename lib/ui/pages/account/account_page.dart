import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/main_page_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/roundedBox_title.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String namaDepan = '';
  String namaBelakang = '';
  @override
  void initState() {
    getDataUser();

    super.initState();
  }

  void getDataUser() async {
    UserStore().getUserDetail().then((value) {
      setState(() {
        namaDepan = value['firstName'] ?? value['username'];
        namaBelakang = value['lastName'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: SizedBox(
                child: Column(
                  children: [
                    Container(
                      color: kWhiteColor,
                      padding: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                        bottom: 14,
                        top: 20,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Profile',
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: extraBold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.5,
                          ),
                          Column(
                            children: [
                              //Avatar
                              Container(
                                height: 90,
                                width: 90,
                                margin: const EdgeInsets.only(bottom: 15),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/image_destination1.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              //ShortInfo
                              Text(
                                '${namaDepan.toTitleCase()} ${namaBelakang.toTitleCase()}',
                                style: blackTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Local Guide Level 2',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    Icons.fiber_manual_record,
                                    size: 8,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '233 point',
                                    style:
                                        blackTextStyle.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getAccountInfo());
                            },
                            child: const RoundedBoxTitle(
                              title: 'Info Profile',
                              icon: Icon(
                                Icons.manage_accounts,
                                size: 19,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getAccountPrivaci());
                            },
                            child: const RoundedBoxTitle(
                              title: 'Privasi dan Pengaturan',
                              icon: Icon(
                                Icons.settings_outlined,
                                size: 19,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getAccountFaq());
                            },
                            child: const RoundedBoxTitle(
                              title: 'FAQ',
                              icon: Icon(
                                Icons.help_outline_rounded,
                                size: 19,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const RoundedBoxTitle(
                              title: 'Komunitas',
                              icon: Icon(
                                Icons.group_outlined,
                                size: 19,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const RoundedBoxTitle(
                              title: 'Rencana Perjalanan',
                              icon: Icon(
                                Icons.near_me_outlined,
                                size: 19,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              var authC = Get.find<AuthController>();
                              var mainPageC = Get.find<MainPageController>();
                              mainPageC.menuTabController.value = 0;
                              authC.logout();
                            },
                            child: const RoundedBoxTitle(
                              title: 'Keluar',
                              icon: Icon(
                                Icons.logout_rounded,
                                size: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
