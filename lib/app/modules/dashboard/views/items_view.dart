import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/cart_page_widget.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/items_dashboard.dart';

import '../controllers/dashboard_controller.dart';

class ItemsView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return CartPageWidget(
        body: ItemsDashboard(),
        title: _.currentFacility.name + " - " + _.currentSubFacility.name,
      );
    });
  }
}
