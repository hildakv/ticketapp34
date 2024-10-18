import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/asset_urls.dart';
import '../../../utils/theme_data.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: FutureBuilder(
          future: controller.initServices(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(AssetUrls.APP_LOGO, height: 100),
                  const Text(
                    'Ticket Solution',
                    style: TextStyle(color: primaryColor, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                  ),
                  const SizedBox(height: 42),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
