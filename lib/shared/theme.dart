import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Global Color References
const kNeutral20 = AppColors.neutral20;
const kNeutral30 = AppColors.neutral30;
const kNeutral40 = AppColors.neutral40;
const kNeutral50 = AppColors.neutral50;
const kNeutral60 = AppColors.neutral60;
const kNeutral70 = AppColors.neutral70;
const kNeutral80 = AppColors.neutral80;
const kNeutral90 = AppColors.neutral90;

const kBlackColor = AppColors.blackColor;
const kWhiteColor = AppColors.whiteColor;

const kBlueColor = AppColors.blueColor;
const kBlueColorHover = AppColors.blueSurfaceHover;
const kBluePressed = AppColors.bluePressed;
const kBlueSurface = AppColors.blueSurface;
const kPrimarySurface = AppColors.blueSurface;

const kSuccessMain = AppColors.successMain;
const kSuccessSurface = AppColors.successSurface;
const kSuccessHover = AppColors.successHover;

const kErrorMain = AppColors.errorMain;
const kRedMain = AppColors.redMain;
const kRedColor = AppColors.redMain;

const kWarningMain = AppColors.warningMain;

const kBackgroundColor = AppColors.backgroundColorLight;

const kGreenHover = AppColors.greenHover;
const kAvailableColor = AppColors.blueSurface;

const kGreyColor = AppColors.neutral60;
const kSecondaryMain = AppColors.bluePressed;

// Global Typography References
final blackTextStyle = AppTypography.blackTextStyle;
final whiteTextStyle = AppTypography.whiteTextStyle;
final greyTextStyle = AppTypography.greyTextStyle;
final blueTextStyle = AppTypography.blueTextStyle;
final noColorTextStyle = AppTypography.noColorTextStyle;

// Global Font Weight References
final light = AppFontWeight.light;
final regular = AppFontWeight.regular;
final medium = AppFontWeight.medium;
final semiBold = AppFontWeight.semiBold;
final bold = AppFontWeight.bold;
final extraBold = AppFontWeight.extraBold;

// Global Dimension References
const defaultMargin = AppDimensions.defaultMargin;
const defaultRadius = AppDimensions.defaultRadius;

// Comprehensive Color Palette
class AppColors {
  // Neutral Colors
  static const Color neutral20 = Color(0xFFF5F5F5);
  static const Color neutral30 = Color(0xFFE0E0E0);
  static const Color neutral40 = Color(0xFFBDBDBD);
  static const Color neutral50 = Color(0xFF9E9E9E);
  static const Color neutral60 = Color(0xFF757575);
  static const Color neutral70 = Color(0xFF616161);
  static const Color neutral80 = Color(0xFF424242);
  static const Color neutral90 = Color(0xFF212121);
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);

  // Primary Colors
  static const Color blueColor = Color(0xFF2196F3);
  static const Color blueSurface = Color(0xFFE3F2FD);
  static const Color blueSurfaceHover = Color(0xFFBBDEFB);
  static const Color bluePressed = Color(0xFF1976D2);

  // Semantic Colors
  static const Color successMain = Color(0xFF4CAF50);
  static const Color successSurface = Color(0xFFE8F5E9);
  static const Color successHover = Color(0xFF388E3C);

  static const Color errorMain = Color(0xFFF44336);
  static const Color errorSurface = Color(0xFFFFEBEE);
  static const Color redMain = Color(0xFFD32F2F);

  static const Color warningMain = Color(0xFFFFC107);
  static const Color warningSurface = Color(0xFFFFF3E0);

  // Background Colors
  static const Color backgroundColorLight = Color(0xFFFAFAFA);
  static const Color backgroundColorDark = Color(0xFFF5F5F5);

  // Interaction Colors
  static const Color greenHover = Color(0xFF2E7D32);
  static const Color blueColorHover = Color(0xFF1565C0);
}

// Typography and Text Styles
class AppTypography {
  // Base Text Styles
  static TextStyle get blackTextStyle => GoogleFonts.poppins(
        color: AppColors.blackColor,
      );

  static TextStyle get whiteTextStyle => GoogleFonts.poppins(
        color: AppColors.whiteColor,
      );

  static TextStyle get greyTextStyle => GoogleFonts.poppins(
        color: AppColors.neutral60,
      );

  static TextStyle get blueTextStyle => GoogleFonts.poppins(
        color: AppColors.blueColor,
      );

  // No Color Text Style (for dynamic color application)
  static TextStyle get noColorTextStyle => GoogleFonts.poppins();
}

// Font Weights
class AppFontWeight {
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
}

// Spacing and Dimensions
class AppDimensions {
  static const double defaultMargin = 16.0;
  static const double defaultRadius = 8.0;
}

// Theme Configuration
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: AppColors.blueColor,
        scaffoldBackgroundColor: AppColors.backgroundColorLight,
        textTheme: TextTheme(
          bodyLarge: AppTypography.blackTextStyle,
          bodyMedium: AppTypography.blackTextStyle,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          foregroundColor: AppColors.blackColor,
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.blueColor,
          secondary: AppColors.bluePressed,
          surface: AppColors.backgroundColorLight,
        ),
      );
}
