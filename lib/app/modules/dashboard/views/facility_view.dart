import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app/app/modules/dashboard/views/ticket_cart_view.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/cart_page_widget.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_cart_bar.dart';

import '../controllers/dashboard_controller.dart';
import 'widgets/facility_items.dart';

class FacililtyView extends GetView<DashboardController> {
  const FacililtyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CartPageWidget(
        body: FacilityItems(), title: "Facilites", needDrawer: true);
  }
}
