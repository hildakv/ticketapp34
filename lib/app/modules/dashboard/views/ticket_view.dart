import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_app/app/modules/dashboard/views/ticket_cart_view.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_cart_bar.dart';
import 'package:ticket_app/app/utils/cache/ticket_category_cache.dart';

import '../../../models/ticket.dart';
import '../../../models/ticket_item.dart';
import '../../../utils/widgets/counter_widget ex.dart';
import '../../../utils/widgets/text_ex.dart';

class TicketView extends StatelessWidget {
  final Ticket ticket;

  final TicketCategoryCache cache = TicketCategoryCache.get();

  TicketView({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextEx(this.ticket.id),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.deepPurple.shade100),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ListView(
                children: [..._buildCartDetails()],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // height: 100,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextEx("Total Amount:"),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepPurple.shade300),
                      child: TextEx("Rs. ${ticket.total}"))
                ]),
              ),
            ),
            // Expanded(flex: 1, child: _buildActionBar())
          ],
        ),
      ),
    );
  }

  _buildActionBar() {
    if (this.ticket.status == TicketStatus.PRINTED) {
      return Container();
    }

    if (this.ticket.status == TicketStatus.PAID) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue.shade100),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: TextEx("Print"))
        ]),
      );
    }

    if (this.ticket.status == TicketStatus.CREATED) {
      return TicketCartBar(onClicked: () {
        Get.to(TicketCartView());
      });
    }
  }

  _buildCartDetails() {
    List<Widget> widgets = [];
    print("$ticket");
    print("${ticket.total}");
    this.ticket.details.entries.forEach((facility) {
      print("${facility.key}");
      widgets.add(TextEx(
        cache.getFacilityName(facility.key),
      ));
      widgets.add(SizedBox(
        height: 10,
      ));
      facility.value.items.entries.forEach((subFacilities) {
        widgets.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.blueGrey),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextEx(cache.getSubFacilityName(subFacilities.key) ??
                  "Sub Facility"),
              ..._buildTicketItemsEx(subFacilities.key, subFacilities.value)
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

  _buildTicketItemsEx(String subFacilityId, Map<String, TicketItem> items) {
    return items.entries.map((e) {
      var item = e.value;

      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blueAccent.shade100,
          ),
          height: 70,
          // color: Colors.teal[100],
          child: Row(
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
                  flex: 2,
                  child: Text(
                    'Rs. ${item.rate}',
                    style: GoogleFonts.abel(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              // Expanded(
              //     flex: 3,
              //     child: Column(
              //       children: [
              //         Expanded(
              //             flex: 2,
              //             child: Center(
              //               child: Text(
              //                 item.name,
              //                 style: GoogleFonts.abel(
              //                     fontSize: 20, fontWeight: FontWeight.bold),
              //               ),
              //             )),
              //         Expanded(
              //             flex: 1,
              //             child: Text(
              //               'Rs. ${item.rate}',
              //               style: GoogleFonts.abel(
              //                   fontSize: 15, fontWeight: FontWeight.bold),
              //             ))
              //       ],
              //     )),
              Expanded(
                  flex: 3,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TextEx("${item.count}"),
                  )),
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
