import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ticket_app/app/services/local_storage_service.dart';

import '../models/user.dart';
import '../routes/app_pages.dart';
import '../utils/api_helper/api_helper.dart';
import '../utils/api_urls.dart';
import 'user_services.dart';

class AuthServices {
  static final apiHelper = ApiHelper();

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final formData = {
        'username': username,
        'password': password,
        'serial_no': 'asdf123'
      };

      final apiResponse = await apiHelper.postData(ApiUrls.LOGIN, formData);
      final Map<String, dynamic> result;

      if (apiResponse['success'] as bool) {
        final jsonData = apiResponse['data'];
        if (jsonData['status'] as bool) {
          final jsonDataContent = jsonData['data'] as Map<String, dynamic>;
          final user =
              User.fromJson(jsonDataContent['user'] as Map<String, dynamic>);
          String? authToken = user.accessToken;
          user.accessToken = 'Bearer $authToken';
          print('$user.accessToken');
          user.tokenExpiryDate =
              DateTime.parse(jsonDataContent['user']['expires_at'] as String);
          // final user =
          //     User.fromJson(jsonData['data']['user'] as Map<String, dynamic>);
          // user.accessToken = jsonData['access_token'] as String;
          await Get.find<UserServices>().saveUser(user);
          //  await FirebaseServices.updateFcmToken();
          await GetStorage.init('${user.userId}');

          result = {'status': true};
        } else {
          result = {'status': false, 'message': jsonData['data']['message']};
        }
      } else {
        result = {'status': false, 'message': apiResponse['error']};
      }

      return result;
    } catch (e) {
      if (kDebugMode) rethrow;
      // rethrow;
      // logger.e(e);

      return {'status': false, 'message': 'Error occured. Please try again.'};
    }
  }

  static Future<bool> refreshToken() async {
    try {
      final formData = {
        'user_id': Get.find<UserServices>().user!.userId,
        'refresh_token': Get.find<UserServices>().user!.refreshToken,
        'client_secret': Get.find<UserServices>().user!.clientSecret
      };
      final apiResponse =
          await apiHelper.postData(ApiUrls.REFRESH_TOKEN, formData);
      if (apiResponse['success'] as bool) {
        final jsonData = apiResponse['data'] as Map<String, dynamic>;
        final jsonDataContent = jsonData['data'] as Map<String, dynamic>;
        if (jsonData['status'] as bool) {
          final user = Get.find<UserServices>().user!;
          user.accessToken = 'Bearer ${jsonDataContent['access_token']}';
          user.tokenExpiryDate =
              DateTime.parse(jsonDataContent['expires_at'] as String);
          await Get.find<UserServices>().saveUser(user);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e, s) {
      if (kDebugMode) rethrow;
      // FirebaseCrashlytics.instance.recordError(e, s);

      return false;
    }
  }

  static void logout() {
    Get.find<UserServices>().removeUser();
    LocalStorageService.instance().removeFacility();
    Get.offAllNamed(Routes.LOGIN);
  }
}

// class AuthServices {
//   static final apiHelper = ApiHelper();

//   static Future<Map<String, dynamic>> login({
//     required String username,
//     required String password,
//   }) async {
//     try {
//       final formData = {
//         'username': username,
//         'password': password,
//         'serial_no': 'asdf123'
//       };
//       final apiResponse = await apiHelper.postData(ApiUrls.LOGIN, formData);
//       if (apiResponse['success'] as bool) {
//         final jsonData = apiResponse['data'] as Map<String, dynamic>;
//         if (jsonData['status'] as bool) {
//           final user = User.fromJson(jsonData['user'] as Map<String, dynamic>);
//           // user.accessToken = jsonData['access_token'] as String;
//           // user.tokenExpiryDate =
//           //     DateTime.parse(jsonData['expires_at'] as String);
//           await Get.find<UserServices>().saveUser(user);
//           //  await FirebaseServices.updateFcmToken();
//           await GetStorage.init('${user.userId}');
//           return {'success': true};
//         } else {
//           return {'success': false, 'error': jsonData['error']};
//         }
//       } else {
//         return {'success': false, 'error': apiResponse['error']};
//       }
//     } catch (e) {
//       if (kDebugMode) rethrow;

//       return {'success': false, 'error': 'Error occured. Please try again.'};
//     }
//   }

 

  // static Future<User?> getUser() async {
  //   try {
  //     final apiResponse = await apiHelper.getData(ApiUrls.USER);
  //     if (apiResponse['success'] as bool) {
  //       final jsonData = apiResponse['data'] as Map<String, dynamic>;
  //       if (jsonData['status'] as bool) {
  //         return User.fromJson(jsonData['user'] as Map<String, dynamic>);
  //       }
  //     }

  //     return null;
  //   } catch (e) {
  //     if (kDebugMode) rethrow;

  //     return null;
  //   }
  // }

  // static Future<void> logout() async {
  //   try {
  //     await apiHelper.postData(ApiUrls.LOGOUT, {});
  //   } finally {
  //     await Get.find<UserServices>().removeUser();
  //     Get.offAllNamed(Routes.LOGIN);
  //   }
  // }
// }
