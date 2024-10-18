import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/auth_services.dart';
import '../../../../services/user_services.dart';
import '../../../../utils/asset_urls.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/dashboard_controller.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            GetBuilder<DashboardController>(
              builder: (_) {
                String displayName = '';
                displayName =
                    'Organization: ${Get.find<UserServices>().user!.organisation}';
                displayName +=
                    '\nOffice: ${Get.find<UserServices>().user!.office}';

                return UserAccountsDrawerHeader(
                  accountName: Text(Get.find<UserServices>().user!.name),
                  // Text("User"),
                  accountEmail: Text(displayName),
                  currentAccountPicture: CircleAvatar(
                    child:
                        // Text(displayName[0]),
                        Text(
                      Get.find<UserServices>().user!.name[0],
                      style: const TextStyle(fontSize: 40.0),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage(AssetUrls.ABSTRACT_BACKGROUND),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        primaryColor.withOpacity(0.5),
                        BlendMode.multiply,
                      ),
                    ),
                  ),
                );
              },
            ),
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Dashboard'),
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  Get.toNamed(Routes.DASHBOARD);
                }),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Get.back(),
                    ),
                    TextButton(
                      child: const Text('Logout'),
                      onPressed: () => AuthServices.logout(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
