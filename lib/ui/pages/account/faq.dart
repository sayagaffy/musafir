import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/shared/theme.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
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
                          'FAQ',
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
