import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LoginBaseController extends GetxController {
  final loginFormKey = GlobalKey<FormBuilderState>();

  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // IosDeviceInfo info = await deviceInfo.iosInfo;

  bool _showPassword = false;
  bool _isLogging = false;

  bool get showPassword => _showPassword;
  set showPassword(bool v) => {_showPassword = v, update()};

  bool get isLogging => _isLogging;
  set isLogging(bool v) => {_isLogging = v, update()};
}
