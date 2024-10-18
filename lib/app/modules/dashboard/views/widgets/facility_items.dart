import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/dashboard_controller.dart';
import '../items_view.dart';
import '../subfacility_view.dart';

class FacilityItems extends StatelessWidget {
  //const FacilityItems({super.key});
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (_) {
      return Container(
          child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _.facilities.length,
        // itemCount: _.categoryItems.length,
        itemBuilder: (context, index) {
          var facility = _.facilities[index];
          return GestureDetector(
            onTap: () {
              _.currentFacility = facility;
              // _showAlertDialog(_tickets[index], model);
              if (_.currentFacility.subfacilities.length == 1) {
                _.currentSubFacility = facility.subfacilities.first;
                Get.to(() => ItemsView());
              } else
                Get.to(() => SubfacilityView());
              // Get.toNamed(Routes.SUBFACILITY, arguments: [facility]);
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
                              //     image: FadeInImage(
                              //       image: (facility.url.startsWith("http")
                              //               ? NetworkImage(facility.url)
                              //               : AssetImage(facility.url))
                              //           as ImageProvider,
                              //       placeholder:
                              //           AssetImage("assets/images/entry.jpg"),
                              //       imageErrorBuilder:
                              //           (context, error, stackTrace) => Image(
                              //               image: AssetImage(
                              //                   "assets/images/entry.jpg")),
                              //     ).image
                              // image: NetworkImage(facility.url, )
                              // image: CachedNetworkImage(
                              //   imageUrl: facility.url,
                              //   placeholder: (context, url) => Image(
                              //     image: AssetImage("assets/images/entry.jpg"),
                              //   ),
                              //   errorWidget: (context, url, error) => Image(
                              //     image: AssetImage("assets/images/entry.jpg"),
                              //   ),
                              // ),
                              // image: CachedNetworkImageProvider(facility.url)
                              // image: facility.url.startsWith('asset')
                              //     ? AssetImage(facility.url)
                              //     : CachedNetworkImageProvider(facility.url)
                              //         as ImageProvider,
                              // ),
                              image: AssetImage(
                                "assets/images/entry.jpg",
                              ),
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                      )),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          facility.name,
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
