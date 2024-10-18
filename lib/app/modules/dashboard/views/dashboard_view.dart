import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../utils/theme_data.dart';
import '../controllers/dashboard_controller.dart';
// import 'facility_view_ex.dart';
import 'widgets/dashboard_drawer.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_progress_section.dart';
import 'widgets/facility_items.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: RefreshIndicator(
            onRefresh: () => controller.loadData(),
            child: ListView(
              shrinkWrap: true,
              padding: screenPadding,
              children: [
                DashboardHeader(),
                DashboardProgressSection(),
                Center(
                  child: Column(
                    children: [
                      FacilityItems(),
                    ],
                  ),
                ),
                //DashboardChart(),
              ],
            ),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        drawer: const DashboardDrawer(),
      ),
    );
  }
}
