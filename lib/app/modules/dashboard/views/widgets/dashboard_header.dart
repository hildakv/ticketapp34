import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/user_services.dart';
import '../../../../utils/asset_urls.dart';
import '../../../../utils/general_utils.dart';
import '../../../../utils/global_widgets.dart';
import '../../controllers/dashboard_controller.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: Image.asset(AssetUrls.USER, height: 28),
              onTap: () => Scaffold.of(context).openDrawer(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GetBuilder<DashboardController>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getGreeting()),
                    Text(
                      'name',
                      // Get.find<UserServices>().user?.name ?? '',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        // HEIGHT_12,
      ],
    );
  }
}
