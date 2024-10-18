import 'dart:io';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Notification;
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:in_app_update/in_app_update.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:store_redirect/store_redirect.dart';
// import 'package:update_available/update_available.dart' as update_available;
// import 'package:url_launcher/url_launcher.dart';

// import '../data/models/notification.dart';
import '../utils/api_helper/api_helper.dart';
import '../utils/api_helper/network_util.dart';
import '../utils/api_urls.dart';

class OtherServices {
  static final apiHelper = ApiHelper();
  static final box = GetStorage();

  // static Future<Position?> determinePosition() async {
  //   late final bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error(
  //       'Location services are disabled. Please enable through app settings.',
  //     );
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error(
  //         'Location permissions are denied. Please enable to continue.',
  //       );
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.',
  //     );
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return Geolocator.getCurrentPosition();
  // }

  // static Future<File?> takeImage() async {
  //   final image = await ImagePicker()
  //       .pickImage(source: ImageSource.camera, maxHeight: 800, maxWidth: 800);

  //   return image != null ? File(image.path) : null;
  // }

  // static Future<File> saveImageToLocal(File image) async {
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final path = appDocDir.path;
  //   final fileName = image.path.split('/').last;

  //   return image.copy('$path/$fileName');
  // }

  // static Future<File> getImageFromLocal(String fileName) async {
  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final path = appDocDir.path;

  //   return File('$path/$fileName');
  // }

  // static Future<Map<String, dynamic>> postFeedback(
  //   FormData formData,
  // ) async {
  //   try {
  //     final apiResponse = await apiHelper.postData(
  //       ApiUrls.POST_FEEDBACK,
  //       formData,
  //     );
  //     if (apiResponse['success'] as bool) {
  //       final jsonData = apiResponse['data'] as Map<String, dynamic>;

  //       return jsonData['status'] as bool
  //           ? {'success': true}
  //           : {'success': false, 'error': jsonData['error'] as String};
  //     } else {
  //       return {
  //         'success': false,
  //         'error': apiResponse['error'] as String,
  //       };
  //     }
  //   } catch (e, s) {
  //     if (kDebugMode) rethrow;
  //     FirebaseCrashlytics.instance.recordError(e, s);

  //     return {
  //       'success': false,
  //       'error': 'Error occured. Please try again later',
  //     };
  //   }
  // }

  // static Future<AppUpdateInfo?> checkForUpdate() async {
  //   try {
  //     if (Platform.isAndroid) {
  //       return await InAppUpdate.checkForUpdate();
  //     }

  //     return null;
  //   } catch (e, s) {
  //     if (kDebugMode) rethrow;
  //     FirebaseCrashlytics.instance.recordError(e, s);

  //     return null;
  //   }
  // }

  // static Future<void> updateApp() async {
  //   try {
  //     final updateInfo = await checkForUpdate();
  //     if (updateInfo?.updateAvailability ==
  //         UpdateAvailability.updateAvailable) {
  //       await InAppUpdate.performImmediateUpdate();
  //     }
  //   } catch (e, s) {
  //     if (kDebugMode) rethrow;
  //     FirebaseCrashlytics.instance.recordError(e, s);
  //   }
  // }

  // static Future<Map<String, dynamic>> sendTestNotification() async {
  //   try {
  //     final apiResponse = await apiHelper.postData(
  //       ApiUrls.SEND_TEST_NOTIFICATION,
  //       {},
  //     );
  //     if (apiResponse['success'] as bool) {
  //       final jsonData = apiResponse['data'] as Map<String, dynamic>;

  //       return jsonData['status'] as bool
  //           ? {'success': true}
  //           : {'success': false, 'error': jsonData['error'] as String};
  //     } else {
  //       return {
  //         'success': false,
  //         'error': apiResponse['error'] as String,
  //       };
  //     }
  //   } catch (e, s) {
  //     if (kDebugMode) rethrow;
  //     FirebaseCrashlytics.instance.recordError(e, s);

  //     return {
  //       'success': false,
  //       'error': 'Error occured. Please try again later',
  //     };
  //   }
  // }

  // static Future<List<Notification>> getNotifications() async {
  //   try {
  //     if (await DataConnectionChecker().hasConnection) {
  //       final apiResponse = await apiHelper.getData(ApiUrls.GET_NOTIFICATIONS);
  //       if (apiResponse['success'] as bool) {
  //         final jsonData = apiResponse['data'] as Map<String, dynamic>;
  //         if (jsonData['status'] as bool) {
  //           final jsonDataInner = jsonData['data'] as Map<String, dynamic>;
  //           final notifications = jsonDataInner['notifications'] as List;

  //           await box.write(
  //             'notifications',
  //             notifications,
  //           );

  //           return notifications.map((notification) {
  //             return Notification.fromJson(
  //               notification as Map<String, dynamic>,
  //             );
  //           }).toList();
  //         } else {
  //           return [];
  //         }
  //       } else {
  //         return [];
  //       }
  //     } else {
  //       final notifications = await box.read('notifications') ?? [];

  //       return (notifications as List).map((notification) {
  //         return Notification.fromJson(
  //           notification as Map<String, dynamic>,
  //         );
  //       }).toList();
  //     }
  //   } catch (e, s) {
  //     if (kDebugMode) rethrow;
  //     FirebaseCrashlytics.instance.recordError(e, s);

  //     return [];
  //   }
  // }

  // static Future<void> checkUpdateAvailable() async {
  //   final availability = await update_available.getUpdateAvailability();

  //   final isUpdateAvailable = availability.fold(
  //     available: () => true,
  //     notAvailable: () => false,
  //     unknown: () => false,
  //   );

  //   if (isUpdateAvailable) {
  //     showDialog(
  //       context: Get.context!,
  //       builder: (_) => AlertDialog(
  //         title: const Text('Update Available'),
  //         content:
  //             const Text('An update is available. Do you want to update now?'),
  //         actions: [
  //           TextButton(onPressed: () => Get.back(), child: const Text('No')),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               onPrimary: Theme.of(Get.context!).colorScheme.onPrimary,
  //               primary: Theme.of(Get.context!).colorScheme.primary,
  //             ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
  //             onPressed: () => StoreRedirect.redirect(),
  //             child: const Text('Update'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

  // static Future<void> openGoogleMap(String latitude, String longitude) async {
  //   try {
  //     final mapUri = Uri(
  //       scheme: 'geo',
  //       host: '0,0',
  //       queryParameters: {'q': '$latitude,$longitude'},
  //     );

  //     await launchUrl(mapUri);
  //   } catch (e, s) {
  //     if (kDebugMode) rethrow;
  //     FirebaseCrashlytics.instance.recordError(e, s);
  //   }
  // }
}
