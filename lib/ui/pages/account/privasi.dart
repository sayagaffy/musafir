import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';

class Privasi extends StatefulWidget {
  const Privasi({super.key});

  @override
  State<Privasi> createState() => _PrivasiState();
}

class _PrivasiState extends State<Privasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child:
                                const Icon(Icons.keyboard_backspace_rounded)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Privasi dan Pengaturan',
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: extraBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
