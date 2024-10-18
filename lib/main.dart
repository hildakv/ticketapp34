import 'dart:async';

// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ticket_app/app/services/local_storage_service.dart';

import 'app/routes/app_pages.dart';
// import 'app/utils/general_utils.dart';
import 'app/utils/general_utils.dart';
import 'app/utils/theme_data.dart';

Future<void> main() async {
  await LocalStorageService.init();
  runZonedGuarded<Future<void>>(() async {
    await initializeApp();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then(
      (_) => runApp(
        GetMaterialApp(
          title: 'Keltron Ticket Solution',
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          theme: themeData,
          // routingCallback: routingCallback,
          navigatorObservers: [
            //FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
          ],
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
          ],
        ),
      ),
    );
  }, (error, stack) => {}
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
      );
}
