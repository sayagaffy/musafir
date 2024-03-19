import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 18.0;
double defaultRadius = 25.0;

const Color kPrimaryColor = Color(0xffFDB82C);
const Color kBlackColor = Color(0xff191D23);
const Color kWhiteColor = Color(0xffFFFFFF);
const Color kGreyColor = Color(0xff9698A9);
const Color kGreyBorderColor = Color(0xffC8C9CA);
const Color kGreenColor = Color(0xff0EC3AE);
const Color kRedColor = Color(0xffEB70A5);
const Color kBackgroundColor = Color(0xffFAFAFA);
const Color kInactiveColor = Color(0xffDBD7EC);
const Color kTransparentColor = Colors.transparent;
const Color kAvailableColor = Color(0xffE0D9FF);
const Color kUnavailableColor = Color(0xffEBECF1);

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
