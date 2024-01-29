import 'package:flutter/material.dart';

import 'package:musafir/ui/pages/home_page.dart';
import 'package:musafir/ui/pages/sign_up_page.dart';

import 'package:musafir/ui/widgets/custom_page_route.dart';
import '../../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pushNamed(context, '/get-started');
    // });
    super.initState();
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              margin: const EdgeInsets.only(bottom: 50),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icon_musafir.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 339,
              height: 44,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kBackgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(CustomPageRoute(
                    child: const HomePage(),
                    direction: AxisDirection.left,
                  ));
                },
                child: Text(
                  'Masuk',
                  style: blackTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 339,
              height: 44,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(CustomPageRoute(
                    child: const SignUpPage(),
                    direction: AxisDirection.up,
                  ));
                },
                child: Text(
                  'Daftar',
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: semiBold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
