import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 18.0;
double defaultRadius = 25.0;

Color kPrimaryColor = const Color(0xffFDB82C);
Color kBlackColor = const Color(0xff191D23);
Color kWhiteColor = const Color(0xffFFFFFF);
Color kGreyColor = const Color(0xff7B7B7B);
Color kGreenColor = const Color(0xff0EC3AE);
Color kRedColor = const Color(0xffEB70A5);
Color kBlueColor = const Color(0xff4789CE);
Color kBackgroundColor = const Color(0xffFAFAFA);
Color kInactiveColor = const Color(0xffDBD7EC);
Color kTransparentColor = Colors.transparent;
Color kAvailableColor = const Color(0xffE0D9FF);
Color kUnavailableColor = const Color(0xffEBECF1);

TextStyle blackTextStyle = GoogleFonts.manrope(
  color: kBlackColor,
);

TextStyle whiteTextStyle = GoogleFonts.manrope(
  color: kWhiteColor,
);
TextStyle greyTextStyle = GoogleFonts.manrope(
  color: kGreyColor,
);
TextStyle greenTextStyle = GoogleFonts.manrope(
  color: kGreenColor,
);
TextStyle redTextStyle = GoogleFonts.manrope(
  color: kRedColor,
);
TextStyle purpleTextStyle = GoogleFonts.manrope(
  color: kPrimaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
