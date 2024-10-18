import 'dart:developer';

import 'package:flutter/material.dart' hide Key;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_pages.dart';
import '../services/firebase_services.dart';
// import '../services/other_services.dart';
import '../services/local_storage_service.dart';
import '../services/user_services.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Get.putAsync(() async => UserServices().init());
  // await Get.putAsync(() async => LocalStorageService().init());
  // await LocalStorageService.init();
  // await FirebaseServices.initFirebase();
  // await FirebaseServices.initAnalystics();

  // if (Get.find<UserServices>().user != null) {
  //   // await GetStorage.init('${Get.find<UserServices>().user!.userId}');
  //   // await OtherServices.getNotifications();
  //   await FirebaseServices.initPushNotification();
  // }
}

extension StringCasingExtension on String {
  String get titleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalizeFirst)
      .join(' ');
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return numericDates ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return numericDates ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return numericDates ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return numericDates ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}

void removeCurrentFocus(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

// void routingCallback(Routing? routing) {
//   if (Get.currentRoute == Routes.APPLICATIONS && routing?.isBack == true) {
//     Get.find<ApplicationsController>().update();
//   }
//   log(routing.toString());
// }

String removeTrailingZeros(String value) {
  return value.replaceAll(RegExp(r'\:00+$'), '');
}

String getGreeting() {
  final hour = TimeOfDay.now().hour;
  if (hour > 0 && hour <= 12) {
    return 'Good Morning';
  } else if (hour > 12 && hour <= 18) {
    return 'Good Afternoon';
  } else if (hour > 18 && hour <= 24) {
    return 'Good Evening';
  } else {
    return 'Hello';
  }
}
