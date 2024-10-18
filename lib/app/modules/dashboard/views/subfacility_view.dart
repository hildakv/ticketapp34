import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/cart_page_widget.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/subfacility_items.dart';

import '../controllers/dashboard_controller.dart';

class SubfacilityView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return CartPageWidget(
        body: SubFacilityItems(),
        title: _.currentFacility.name,
      );
    });
  }
}
