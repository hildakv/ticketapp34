import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_cart_bar.dart';

import '../ticket_cart_view.dart';
import 'dashboard_drawer.dart';

class CartPageWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final bool needDrawer;

  CartPageWidget(
      {required this.body, required this.title, this.needDrawer = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _getDrawer(this.needDrawer),
      appBar: AppBar(
        title: Text(this.title),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
            flex: 3,
            child: this.body,
            // child: DashBoardSubcategory(),
            // child: DashBoardList(),
          ),
          Expanded(
              flex: 0,
              child: TicketCartBar(
                onClicked: () {
                  Get.to(TicketCartView());
                },
              ))
          // SizedBox(height: 50,)
        ],
      )),
    );
  }

  _getDrawer(bool isrequired) {
    if (isrequired)
      return DashboardDrawer();
    else
      return null;
  }
}
