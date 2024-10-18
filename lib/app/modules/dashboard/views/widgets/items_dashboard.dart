import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:ticket_app/app/models/category_item.dart';
// import 'package:ticket_app/app/models/subcategory_item.dart';
import 'package:ticket_app/app/models/ticket_item.dart';
// import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_entry_sheet.dart';
import 'package:ticket_app/app/utils/widgets/counter_widget.dart';

// import '../../../../models/facility.dart';
// import '../../../../models/ticket_payment_details.dart';
import '../../../../utils/cache/ticket_category_cache.dart';
import '../../../../utils/widgets/counter_widget ex.dart';
import '../../controllers/dashboard_controller.dart';

class ItemsDashboard extends StatelessWidget {
  final TicketCategoryCache cache = TicketCategoryCache.get();
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) {
        print("builiding items.");
        return Container(
          child: ListView.builder(
              itemCount: _.currentSubFacility.items.length,
              itemBuilder: (context, index) {
                var item = _.currentSubFacility.items[index];
                String facility = cache.getFacilityName(item.facilityId) ?? '';
                String subfacility =
                    cache.getSubFacilityName(item.subFacilityId) ?? '';
                if (facility.compareTo(subfacility) == 0) subfacility = '';
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(1, 1))
                        ]),
                    height: 70,
                    // color: Colors.teal[100],
                    child: Row(
                      children: [
                        // Expanded(
                        //     flex: 1,
                        //     child: Column(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.all(0),
                        //           child: Text(facility,
                        //               style: GoogleFonts.abel(
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.bold)),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.all(0),
                        //           child: Text(subfacility,
                        //               style: GoogleFonts.abel(
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.bold)),
                        //         ),
                        //       ],
                        //     )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                item.name,
                                style: GoogleFonts.abel(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                                alignment: AlignmentDirectional.center,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Rs. ${item.rate}',
                                  style: GoogleFonts.abel(
                                      color: Colors.purple.shade700,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ))),
                        // Expanded(
                        //     flex: 3,
                        //     child: Column(
                        //       children: [
                        //         Expanded(
                        //             flex: 2,
                        //             child: Text(
                        //               item.name,
                        //               style: GoogleFonts.abel(
                        //                   fontSize: 20,
                        //                   fontWeight: FontWeight.bold),
                        //             )),
                        //         Expanded(
                        //             flex: 2,
                        //             child: Container(
                        //                 margin: EdgeInsets.all(2),
                        //                 padding: EdgeInsets.all(5),
                        //                 decoration: BoxDecoration(
                        //                     color: Colors.blueGrey.shade100,
                        //                     borderRadius:
                        //                         BorderRadius.circular(5)),
                        //                 child: Text(
                        //                   'Rs. ${item.rate}',
                        //                   style: GoogleFonts.abel(
                        //                       color: Colors.purple.shade700,
                        //                       fontSize: 15,
                        //                       fontWeight: FontWeight.bold),
                        //                 ))),
                        //       ],
                        //     )),
                        Expanded(
                            flex: 2,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: CounterWidgetEx(
                                  value: _.getItemCount(
                                      _.currentSubFacility.id, item.id),
                                  onChanged: (value) {
                                    print("value ---> $value");
                                    _.updatePayementDetails(
                                        _.currentSubFacility.id, [
                                      TicketItem(
                                          itemId: item.id,
                                          facilityId: _.currentFacility.id,
                                          subFacilityId:
                                              _.currentSubFacility.id,
                                          name: item.name,
                                          rate: item.rate,
                                          count: value)
                                    ]);
                                  },
                                ))),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
