// halal_status_util.dart
import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class HalalStatusUtil {
  static Map<String, dynamic> getStatusInfo(int? status) {
    switch (status) {
      case 1:
        return {
          'background': kSuccessSurface,
          'text': kSuccessHover,
          'icon': 'assets/icon_halal.png',
          'displayText': 'Halal-Certified',
          'description':
              'Restoran ini telah mendapatkan sertifikasi halal resmi',
        };
      case 2:
        return {
          'background': kBlueColor,
          'text': kBlueColor,
          'icon': 'assets/icon_halal_blue.png',
          'displayText': 'Halal-Friendly',
          'description': 'Restoran ini menyajikan menu halal',
        };
      case 3:
        return {
          'background': kBluePressed,
          'text': kBluePressed,
          'icon': 'assets/muslim_friendly.png',
          'displayText': 'Muslim-Friendly',
          'description': 'Restoran ini ramah muslim',
        };
      default:
        return {
          'background': const Color(0xFFF5F5F5),
          'text': kBlackColor,
          'icon': 'assets/icon_halal_black.png',
          'displayText': 'Status halal belum terjamin',
          'description': 'Status kehalalan restoran ini belum diverifikasi',
        };
    }
  }
}
