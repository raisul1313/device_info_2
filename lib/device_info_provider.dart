import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  static final _deviceInfoPlugin = DeviceInfoPlugin();

  static Future<String> getDeviceManufacturerInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return '${iosInfo.name}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceModelInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return '${iosInfo.model}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceAPiInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.version.sdkInt.toString();
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return '${iosInfo.systemVersion}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceBrandInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.brand;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return '${iosInfo.model}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getDeviceID() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfoPlugin.iosInfo;
      return '${iosInfo.identifierForVendor}';
    } else {
      throw UnimplementedError();
    }
  }

  static Future<String> getAppVersionInfo() async {
    if (Platform.isAndroid) {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } else {
      throw UnimplementedError();
    }
  }
}
