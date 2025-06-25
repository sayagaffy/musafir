import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceCompatibility {
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // Check if device is Xiaomi/MIUI
  static Future<bool> isXiaomiDevice() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String manufacturer = androidInfo.manufacturer.toLowerCase();
      String brand = androidInfo.brand.toLowerCase();

      return manufacturer.contains('xiaomi') ||
          brand.contains('xiaomi') ||
          brand.contains('redmi') ||
          brand.contains('poco');
    }
    return false;
  }

  // Check if device is OPPO
  static Future<bool> isOppoDevice() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String manufacturer = androidInfo.manufacturer.toLowerCase();
      String brand = androidInfo.brand.toLowerCase();

      return manufacturer.contains('oppo') ||
          brand.contains('oppo') ||
          brand.contains('oneplus');
    }
    return false;
  }

  // Check if device needs special handling
  static Future<bool> needsSpecialHandling() async {
    return await isXiaomiDevice() || await isOppoDevice();
  }

  // Get device info for debugging
  static Future<Map<String, String>> getDeviceInfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return {
        'manufacturer': androidInfo.manufacturer,
        'brand': androidInfo.brand,
        'model': androidInfo.model,
        'version': androidInfo.version.release,
        'sdk': androidInfo.version.sdkInt.toString(),
      };
    }
    return {};
  }
}
