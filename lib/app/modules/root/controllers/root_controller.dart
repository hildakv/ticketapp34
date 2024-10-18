import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/auth_services.dart';
import '../../../services/other_services.dart';
import '../../../services/user_services.dart';
import '../../../utils/api_helper/network_util.dart';
import '../../../utils/global_widgets.dart';

class RootController extends GetxController {
  Future initServices() async {
    if (kReleaseMode) {
      // await OtherServices.updateApp();
    }

    if (Get.find<UserServices>().user != null) {
      if (Get.find<UserServices>()
          .user!
          .tokenExpiryDate!
          .isBefore(DateTime.now())) {
        if (await DataConnectionChecker().hasConnection) {
          final res = await AuthServices.refreshToken();
          if (res) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Get.offNamed(Routes.DASHBOARD),
            );
          } else {
            showSnackBar(
              type: SnackbarType.warning,
              message: 'Token expired. Please login again.',
            );
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => Get.offNamed(Routes.HOME),
            );
          }
        } else {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => Get.offNamed(Routes.DASHBOARD),
          );
        }
      }
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.offNamed(Routes.DASHBOARD),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Get.offNamed(Routes.LOGIN),
      );
    }
  }
}
