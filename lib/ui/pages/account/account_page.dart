/// Halaman akun pengguna yang menampilkan informasi profil dan beberapa opsi pengaturan.
///
/// Halaman ini terdiri dari beberapa bagian:
/// - Menampilkan avatar pengguna, nama depan, nama belakang, dan level panduan lokal.
/// - Menyediakan beberapa opsi pengaturan seperti Info Profil, Privasi, FAQ, Komunitas, Rencana Perjalanan, dan Keluar.
///
/// Metode:
/// - `initState`: Memanggil `getDataUser` untuk mengambil data pengguna saat inisialisasi.
/// - `getDataUser`: Mengambil detail pengguna dari `UserStore` dan memperbarui state dengan nama depan dan nama belakang pengguna.
/// - `build`: Membangun tampilan halaman akun dengan berbagai widget.
///
/// Ekstensi:
/// - `StringExtension`: Menyediakan metode untuk mengubah string menjadi huruf kapital dan huruf judul.
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/controllers/auth_controller.dart';
import 'package:musafir/controllers/main_page_controller.dart';
import 'package:musafir/data/firestore/user_store.dart';
import 'package:musafir/routes/routes_helper.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/roundedBox_title.dart';
import 'package:musafir/ui/pages/account/my_reports.dart';
import 'package:musafir/controllers/auth_controller.dart';

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
                              title: 'Privasi',
                              icon: Icon(
                                Icons.policy,
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
                            onTap: () {
                              var mainPageC = Get.find<MainPageController>();
                              mainPageC.menuTabController.value = 1;
                            },
                            child: const RoundedBoxTitle(
                              title: 'Itinerary',
                              icon: Icon(
                                Icons.near_me_outlined,
                                size: 19,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: Navigate to user reports page
                              Get.to(() => const MyReportsPage());
                            },
                            child: const RoundedBoxTitle(
                              title: 'Laporan Saya',
                              icon: Icon(
                                Icons.report_outlined,
                                size: 19,
                              ),
                            ),
                          ),
                          // Conditionally show admin dashboard
                          GetBuilder<AuthController>(
                            builder: (authController) {
                              return authController.checkIsAdmin()
                                  ? GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getAdminReports());
                                      },
                                      child: const RoundedBoxTitle(
                                        title: 'Admin Dashboard',
                                        icon: Icon(
                                          Icons.admin_panel_settings,
                                          size: 19,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              var authC = Get.find<AuthController>();
                              var mainPageC = Get.find<MainPageController>();
                              mainPageC.menuTabController.value = 0;
                              authC.logout();
                            },
                            child: const RoundedBoxTitle(
                              title: 'Log out',
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
