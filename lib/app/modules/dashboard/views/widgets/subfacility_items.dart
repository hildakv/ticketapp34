import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/dashboard_controller.dart';
import '../items_view.dart';

class SubFacilityItems extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return Container(
          child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _.currentFacility.subfacilities.length,
        // itemCount: _.categoryItems.length,
        itemBuilder: (context, index) {
          var item = _.currentFacility.subfacilities[index];
          return GestureDetector(
            onTap: () {
              _.setCurrentSubFacility(item);
              // _showAlertDialog(_tickets[index], model);
              Get.to(() => ItemsView());
              // Get.toNamed(Routes.SUBFACILITY, arguments: [item]);
            },
            child: Container(
              // padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black87, width: 10),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // borderRadius: BorderRadius.only(
                  //     bottomLeft: Radius.circular(10),
                  //     bottomRight: Radius.circular(10)),
                  color: Colors.blue.shade200,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(1, 1))
                  ]),
              // color: Colors.teal[100],
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/entry.jpg",
                                // item.url,
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        // child: Image.asset(
                        //   _tickets[index].iconUrl,
                        // ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          item.name,
                          style: GoogleFonts.abel(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ));
    });
  }
}
