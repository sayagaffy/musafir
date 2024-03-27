import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99.0),
          color: kBlueColor,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.red),
      ),
    );
  }
}
