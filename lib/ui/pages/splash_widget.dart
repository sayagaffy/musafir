import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/ui/pages/auth/sign_in_page.dart';
import 'package:musafir/ui/pages/auth/sign_up_page.dart';
import '../../shared/theme.dart';
import '../../routes/routes_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 210,
                height: 50,
                margin: const EdgeInsets.only(bottom: 50),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/icon_musafir.png',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 339,
              height: 44,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kBlueSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RouteHelper.getsigInPage());
                },
                child: Text(
                  'Masuk',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                    color: kBluePressed,
                    height: 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 339,
              height: 44,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kBlueSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(RouteHelper.getsignUpPage());
                },
                child: Text(
                  'Daftar',
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                    color: kBluePressed,
                    height: 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
