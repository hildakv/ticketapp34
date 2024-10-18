import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_cart_bar.dart';
import 'package:ticket_app/app/utils/widgets/counter_widget%20ex.dart';

import '../../../../models/ticket_item.dart';
import '../../../../utils/cache/ticket_category_cache.dart';
import '../../../../utils/widgets/text_ex.dart';
import '../../controllers/dashboard_controller.dart';

class TicketCart extends StatelessWidget {
  final TicketCategoryCache cache = TicketCategoryCache.get();

  final Color subFacilityBackground;

  final Color itemsBackground;

  final Color bottomBarBackground;

  final Color bottomBarButtonColor;

  final Function() onClicked;

  TicketCart(
      {this.subFacilityBackground = Colors.blue,
      this.itemsBackground = Colors.lightBlue,
      this.bottomBarBackground = Colors.blueAccent,
      this.bottomBarButtonColor = Colors.deepPurple,
      required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return KeyboardDismisser(
        child: Container(
          padding: EdgeInsets.all(10),
          // child: Center(
          //   child: _buildCartDetails(controller),
          // ),
          child: Center(
              child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [..._buildCartDetails(controller)],
                  )),
              // PaymentBottomBar(),
              // _buildCartBar(controller),
              TicketCartBar(
                onClicked: () {
                  this.onClicked();
                },
                backGroundColor: this.bottomBarBackground,
                buttonColor: this.bottomBarButtonColor,
                isPay: true,
              )
            ],
          )),
        ),
      );
    });
  }

  _buildCartDetails(DashboardController controller) {
    List<Widget> widgets = [];
    controller.paymentDetails.entries.forEach((facility) {
      widgets.add(TextEx(
        cache.getFacilityName(facility.key),
      ));
      widgets.add(SizedBox(
        height: 10,
      ));
      facility.value.items.entries.forEach((subFacilities) {
        widgets.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: this.subFacilityBackground),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextEx(cache.getSubFacilityName(subFacilities.key) ??
                  "Sub Facility"),
              ..._buildTicketItemsEx(
                  controller, subFacilities.key, subFacilities.value)
            ],
          ),
        ));

        widgets.add(SizedBox(
          height: 5,
        ));
      });
    });
    return widgets;
  }

  _buildTicketItemsEx(DashboardController _, String subFacilityId,
      Map<String, TicketItem> items) {
    return items.entries.map((e) {
      var item = e.value;

      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: this.itemsBackground,
          ),
          height: 70,
          // color: Colors.teal[100],
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              item.name,
                              style: GoogleFonts.abel(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Text(
                            'Rs. ${item.rate}',
                            style: GoogleFonts.abel(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ))
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: CounterWidgetEx(
                        value: item.count,
                        onChanged: (value) {
                          print("value ---> $value");
                          item.count = value;
                          _.updateTicket(item);
                        },
                      ))),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Rs. ${item.count * item.rate}",
                      style: GoogleFonts.abel(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ),
      );
    }).toList();
  }
}
