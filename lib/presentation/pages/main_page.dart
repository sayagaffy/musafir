import 'package:flutter/material.dart';
import 'package:musafir/data/entities/user.dart';
import 'package:musafir/shared/theme.dart';

class MainPage extends StatelessWidget {
  final User user;
  const MainPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Widget helloWord() {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text(
            (user.toString()),
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
