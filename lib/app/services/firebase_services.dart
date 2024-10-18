// import 'dart:async';

// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../firebase_options.dart';
// import '../routes/app_pages.dart';
// import '../utils/api_helper/api_helper.dart';
// import '../utils/api_helper/network_util.dart';
// import '../utils/api_urls.dart';
// import 'user_services.dart';

// class FirebaseServices {
//   static final apiHelper = ApiHelper();
//   static late final FirebaseAnalytics analytics;

//   static Future<void> initFirebase() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }

//   static Future<void> initAnalystics() async {
//     analytics = FirebaseAnalytics.instance;
//   }

//   static Future<void> initCrashlytics() async {
//     FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
//   }

//   /// Create a [AndroidNotificationChannel] for heads up notifications
//   static const _channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.max,
//   );

//   static final _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<String?> getFcmToken() async {
//     final fcmKey = await FirebaseMessaging.instance.getToken();
//     final userId = Get.find<UserServices>().user?.userId;
//     if (userId != null) {
//       await GetStorage('$userId').write('fcm_key', fcmKey);
//     }

//     return fcmKey;
//   }

//   static Future<void> initPushNotification() async {
//     try {
//       if (await DataConnectionChecker().hasConnection) {
//         updateFcmToken();
//       }

//       /// App opened state
//       FirebaseMessaging.onMessage.listen(_messageHandler);

//       // FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       //   Get.toNamed(Routes.NOTIFICATION);
//       // });

//       // FirebaseMessaging.instance.getInitialMessage().then((message) {
//       //   if (message?.notification != null) {
//       //     Get.toNamed(Routes.NOTIFICATION);
//       //   }
//       // });

//       FirebaseMessaging.onBackgroundMessage(
//         _firebaseMessagingBackgroundHandler,
//       );
//     } catch (e) {
//       if (kDebugMode) rethrow;
//     }
//   }

//   static Future<Map<String, dynamic>> updateFcmToken() async {
//     try {
//       final fcmToken = await FirebaseServices.getFcmToken();
//       final apiResponse = await apiHelper.postData(
//         "",
//         {
//           'fcm_token': fcmToken,
//         },
//       );
//       if (apiResponse['success'] as bool) {
//         final jsonData = apiResponse['data'] as Map<String, dynamic>;

//         return jsonData['status'] as bool
//             ? {'success': true}
//             : {'success': false, 'error': jsonData['error'] as String};
//       } else {
//         return {
//           'success': false,
//           'error': apiResponse['error'] as String,
//         };
//       }
//     } catch (e) {
//       if (kDebugMode) rethrow;

//       return {
//         'success': false,
//         'error': 'Error occured. Please try again later',
//       };
//     }
//   }
// }

// Future<void> _messageHandler(RemoteMessage message) async {
//   if (message.notification != null) {
//     if (message.data.containsKey('show_notification') &&
//         message.data['show_notification'] == 'true') {
//       showNotification(message);
//     }
//   }

//   _handleNotificationData(message);
// }

// Future<void> showNotification(RemoteMessage message) async {
//   /// Initialize the [FlutterLocalNotificationsPlugin] package.
//   await FirebaseServices._flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(FirebaseServices._channel);

//   FirebaseServices._flutterLocalNotificationsPlugin.show(
//     message.notification.hashCode,
//     message.notification?.title,
//     message.notification?.body,
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         FirebaseServices._channel.id,
//         FirebaseServices._channel.name,
//         channelDescription: FirebaseServices._channel.description,
//         icon: 'notification_icon',
//         color: const Color(0xFF0D47A1),
//         importance: Importance.max,
//         styleInformation:
//             BigTextStyleInformation(message.notification?.body ?? ''),
//       ),
//     ),
//   );
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   _messageHandler(message);
// }

// Future<void> _handleNotificationData(RemoteMessage message) async {
//   if (message.data.containsKey('type')) {
//     switch (message.data['type']) {
//       case 'incoming_call':
//     }
//   }
// }
