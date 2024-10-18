import 'dart:convert';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinelab_sdk/pinelab_sdk.dart';
import 'package:ticket_app/app/models/pinelabs/pinelabs_detail_response.dart';
import 'package:ticket_app/app/modules/dashboard/views/items_view.dart';
import 'package:ticket_app/app/modules/dashboard/views/ticket_cart_view.dart';
import 'package:ticket_app/app/modules/dashboard/views/ticket_view.dart';
import 'package:ticket_app/app/services/local_storage_service.dart';
// import 'package:ticket_app/app/models/ticket_payment_details.dart';
import 'package:ticket_app/app/services/pinelabs_payment_service.dart';
import 'package:ticket_app/app/utils/global_widgets.dart';

import '../../../../models/ticket.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/widgets/text_ex.dart';
import '../../controllers/dashboard_controller.dart';

class TicketCartBar extends StatelessWidget {
  final Function() onClicked;

  final Color backGroundColor;

  final Color buttonColor;

  final bool isPay;

  TicketCartBar(
      {required this.onClicked,
      this.backGroundColor = Colors.transparent,
      this.buttonColor = Colors.deepPurple,
      this.isPay = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      var amount = controller.getTotalPaymentAmount();

      if (0.0 == amount) {
        return Container();
      }

      var count = controller.getTotalItemCount();
      return Container(
          // color: Colors.amber,
          padding: EdgeInsets.all(5),
          // margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: backGroundColor
              // color: Color.fromRGBO(84, 186, 185, 1)
              ),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: badges.Badge(
                      // alignment: Alignment.center,
                      position: badges.BadgePosition.topEnd(top: 0, end: 0),
                      // animationDuration: Duration(milliseconds: 1500),
                      badgeAnimation: badges.BadgeAnimation.slide(
                        animationDuration: Duration(milliseconds: 1500),
                      ),
                      stackFit: StackFit.loose,
                      badgeContent: Text("$count"),
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          this.onClicked();
                        },
                      )),
                )),
            Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.centerRight,
                  child: TextEx(
                    "Total:",
                    fontSize: 20,
                  )),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextEx(
                      "Rs. ${controller.getTotalPaymentAmount()}",
                      fontSize: 24,
                    )),
              ),
            ),
            ..._getButtonList(controller, context)
          ]));
    });
  }

  _getButtonList(DashboardController controller, BuildContext context) {
    if (this.isPay) {
      return [
        Expanded(
          flex: 2,
          child: TextButton(
            style: TextButton.styleFrom(
                shadowColor: Colors.white60,
                elevation: 5,
                foregroundColor: Colors.white,
                backgroundColor: buttonColor),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Cash Payment'),
                content:
                    const Text('Are you sure to proceed with cash payment?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Get.back(),
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      var ticket = controller.generateTicket();
                      _printTicket(controller, context, ticket);
                    },
                  ),
                ],
              ),
            ),
            child: Text(
              'Cash',
              style: GoogleFonts.abel(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            style: TextButton.styleFrom(
                shadowColor: Colors.white60,
                elevation: 5,
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Card Payment'),
                content:
                    const Text('Are you sure to proceed with card payment?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Get.back(),
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      PineLabsPaymentService.paymentService
                          .doCardPayment(controller.getTotalPaymentAmount())
                          .then((value) {
                        var ticket = controller.generateTicket();
                        _printTicket(controller, context, ticket);
                      });
                    },
                  ),
                ],
              ),
            ),
            child: Text(
              'Card',
              style: GoogleFonts.abel(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        )
      ];
    } else {
      return [
        Expanded(
          flex: 2,
          child: TextButton(
            style: TextButton.styleFrom(
                shadowColor: Colors.white60,
                elevation: 5,
                foregroundColor: Colors.white,
                backgroundColor: buttonColor),
            onPressed: () {
              this.onClicked();
            },
            child: Text(
              'Pay',
              style: GoogleFonts.abel(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
        )
      ];
    }
  }

  _printTicket(
      DashboardController controller, BuildContext context, Ticket ticket) {
    PineLabsPaymentService.paymentService.doCashPayment(ticket).then((value) {
      ticket.status = TicketStatus.PAID;
      LocalStorageService.instance().saveTicket(ticket);
      controller.clearPaymentDetails();
      // Get.to((ItemsView));
      Get.back();
      showSnackBarWithIcon(
          duration: Duration(seconds: 10),
          type: SnackbarType.success,
          message: "Ticket Printed Successfully.",
          mainButton: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: () {
                Get.to(() => TicketView(
                    ticket:
                        LocalStorageService.instance().getTicket(ticket.id)));
              },
              child: Text("View")));

      print((LocalStorageService.instance().ticketStore.read(ticket.id)));
      // Get.back();
      Get.toNamed(Routes.DASHBOARD);
    }).onError((error, stackTrace) {
      ticket.status = TicketStatus.PAID;
      // LocalStorageService.instance().saveTicket(ticket);
      String? error_msg;
      if (error is PineLabsDetailResponse) {
        var detailResponse = error as PineLabsDetailResponse;
        error_msg = detailResponse.response?.responseMsg;
      } else {
        error_msg = "Unknown Error";
        // Get.back();
        // Get.back();
      }
      // show alert.
      // print(error_msg);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text("$error_msg"),
          actions: [
            TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Get.back();
                  // Get.back();
                  // Get.to(() => TicketView(
                  //     ticket:
                  //         LocalStorageService.instance().getTicket(ticket.id)));
                }),
          ],
        ),
      );
    }).whenComplete(() => Get.back());
  }
}
