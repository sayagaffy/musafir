import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget helloWord() {
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            'HELLO FROM MAIN PAGE',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          helloWord(),
        ],
      ),
    );
  }
}
