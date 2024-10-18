import 'dart:io';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
// import '../../../services/user_services.dart';
import '../../../utils/global_widgets.dart';
import 'login_base_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LoginController extends LoginBaseController {
  Future<void> login() async {
    try {
      print("******************************* loginconroller");
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine}'); //
      } else {
        print('Running on...###');
      }
      if (loginFormKey.currentState?.saveAndValidate() ?? false) {
        isLogging = true;
        final res = await AuthServices.login(
          username:
              (loginFormKey.currentState?.value['username'] ?? '').toString(),
          password:
              (loginFormKey.currentState?.value['password'] ?? '').toString(),
        );
        isLogging = false;
        print("******************************* $res");
        if (res['status'] as bool) {
          isLogging = true;
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          showSnackBar(
            type: SnackbarType.error,
            message: res['message'] as String,
          );
        }
      }
    } catch (e) {
      isLogging = false;
      showSnackBar(
        type: SnackbarType.error,
        message: e.toString(),
      );
    }
  }
}
