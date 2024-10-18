// import 'dart:convert' as convert;
import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
import 'package:ticket_app/app/models/facility.dart';
import 'package:ticket_app/app/services/local_storage_service.dart';
import 'package:ticket_app/app/services/user_services.dart';
import 'package:ticket_app/app/utils/api_helper/api_helper.dart';

// import '../models/item.dart';
// import '../models/subfacility.dart';
// import '../utils/api_urls.dart';
import '../utils/api_helper/network_util.dart';
import '../utils/api_urls.dart';
import '../utils/cache/ticket_category_cache.dart';

class TicketDetailService extends GetxService {
  static final TicketDetailService _service = TicketDetailService();

  static final ApiHelper apiHelper = ApiHelper();

  TicketDetailService();

  factory TicketDetailService.instance() {
    return _service;
  }
  static Future<List<Facility>> getFacilities() async {
    try {
      if (await DataConnectionChecker().hasConnection) {
        final formData = {
          'userid': Get.find<UserServices>().user?.userId ?? ''
        };
        final apiResponse =
            await apiHelper.postData(ApiUrls.FACILITIES, formData);
        if (apiResponse['success'] as bool) {
          final jsonData = apiResponse['data'] as Map<String, dynamic>;
          if (jsonData['status'] as bool) {
            final facility = List<Facility>.from(
              (jsonData['facilities'] as List<dynamic>)
                  .map(
                    (e) => Facility.fromJson(e as Map<String, dynamic>),
                  )
                  .toList(),
            );
            TicketCategoryCache.get().update(facility);
            LocalStorageService.instance().saveFacilities(facility);
          }
          final facility = LocalStorageService.instance().getFacilities();
          TicketCategoryCache.get().update(facility);
          return facility;
        } else {
          final facility = LocalStorageService.instance().getFacilities();
          TicketCategoryCache.get().update(facility);
          return facility;
        }
      } else {
        final facility = LocalStorageService.instance().getFacilities();
        TicketCategoryCache.get().update(facility);
        return facility;
      }
    } catch (e, s) {
      // if (kDebugMode) rethrow;
      // FirebaseCrashlytics.instance.recordError(e, s);

      return [];
    }
  }

  // Future<void> removeFacility() async {
  //   await box.remove('facility');
  // }

//   Future<List<Facility>> getFacilities() async {
//     return Future.delayed(Duration(seconds: 1), () {
//       print("data");
//       var facilities = [
//         Facility(
//             id: "1",
//             name: "Zoo",
//             url: "assets/images/entry.jpg",
//             description: "Zoo",
//             subfacilities: [
//               SubFacility(
//                   id: "11",
//                   facilityId: "1",
//                   url: "assets/images/entry.jpg",
//                   name: "Gate Entry",
//                   description: "Entering Ticket.",
//                   items: [
//                     Item(
//                         id: "111",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Adult",
//                         rate: 10.00),
//                     Item(
//                         id: "112",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Children",
//                         rate: 5.00),
//                     Item(
//                         id: "113",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Senior",
//                         rate: 5.00),
//                     Item(
//                         id: "118",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Item 4",
//                         rate: 10.00),
//                     Item(
//                         id: "119",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Item 5",
//                         rate: 5.00),
//                     Item(
//                         id: "120",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Item 6",
//                         rate: 5.00),
//                     Item(
//                         id: "114",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Item 7",
//                         rate: 10.00),
//                     Item(
//                         id: "115",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Item 8",
//                         rate: 5.00),
//                     Item(
//                         id: "116",
//                         facilityId: "1",
//                         subFacilityId: "11",
//                         name: "Item 9",
//                         rate: 5.00)
//                   ]),
//               SubFacility(
//                   id: "12",
//                   facilityId: "1",
//                   url: "assets/images/entry.jpg",
//                   name: "Camera",
//                   description: "Carrying Camera.",
//                   items: [
//                     Item(
//                         id: "123",
//                         facilityId: "1",
//                         subFacilityId: "12",
//                         name: "Qty",
//                         rate: 15.00)
//                   ]),
//             ]),
//         Facility(
//             id: "2",
//             name: "Aquarium",
//             url: "assets/images/entry.jpg",
//             description: "Aquarium",
//             subfacilities: [
//               SubFacility(
//                   id: "21",
//                   facilityId: "2",
//                   url: "assets/images/entry.jpg",
//                   name: "Gate Entry",
//                   description: "Entering Ticket.",
//                   items: [
//                     Item(
//                         id: "211",
//                         facilityId: "2",
//                         subFacilityId: "21",
//                         name: "Adult",
//                         rate: 10.00),
//                     Item(
//                         id: "212",
//                         facilityId: "2",
//                         subFacilityId: "21",
//                         name: "Children",
//                         rate: 5.00),
//                     Item(
//                         id: "213",
//                         facilityId: "2",
//                         subFacilityId: "21",
//                         name: "Senior",
//                         rate: 5.00)
//                   ]),
//             ]),
//         Facility(
//             id: "3",
//             name: "Museum",
//             // url:
//             //     "http://10.0.2.2:80/ticket_appadmin/storage/app/public/museum.jpg",
//             url: "assets/images/entry.jpg",
//             description: "Mueseum",
//             subfacilities: [
//               SubFacility(
//                   id: "31",
//                   facilityId: "3",
//                   url: "assets/images/entry.jpg",
//                   name: "Gate Entry",
//                   description: "Entering Ticket.",
//                   items: [
//                     Item(
//                         id: "311",
//                         facilityId: "3",
//                         subFacilityId: "31",
//                         name: "Adult",
//                         rate: 10.00),
//                     Item(
//                         id: "312",
//                         facilityId: "3",
//                         subFacilityId: "31",
//                         name: "Children",
//                         rate: 5.00),
//                     Item(
//                         id: "313",
//                         facilityId: "3",
//                         subFacilityId: "31",
//                         name: "Senior",
//                         rate: 5.00)
//                   ]),
//             ]),
//         Facility(
//             id: "4",
//             name: "Vehicle Parking",
//             url: "assets/images/entry.jpg",
//             description: "Vehicle Parking",
//             subfacilities: [
//               SubFacility(
//                   id: "41",
//                   facilityId: "4",
//                   url: "assets/images/entry.jpg",
//                   name: "Vehicle Parking",
//                   description: "Entering Ticket.",
//                   items: [
//                     Item(
//                         id: "411",
//                         facilityId: "4",
//                         subFacilityId: "41",
//                         name: "Four Wheeler",
//                         rate: 40.00),
//                     Item(
//                         id: "412",
//                         facilityId: "4",
//                         subFacilityId: "41",
//                         name: "Two Wheeler",
//                         rate: 25.00),
//                     Item(
//                         id: "413",
//                         facilityId: "4",
//                         subFacilityId: "41",
//                         name: "Others",
//                         rate: 50.00)
//                   ]),
//             ]),
//         Facility(
//             id: "5",
//             name: "Childrens Park",
//             url: "assets/images/entry.jpg",
//             description: "Childrens Park",
//             subfacilities: [
//               SubFacility(
//                   id: "51",
//                   facilityId: "5",
//                   url: "assets/images/entry.jpg",
//                   name: "Childrens Park",
//                   description: "Entering Ticket.",
//                   items: [
//                     Item(
//                         id: "511",
//                         facilityId: "5",
//                         subFacilityId: "51",
//                         name: "Horse Ride",
//                         rate: 40.00),
//                     Item(
//                         id: "512",
//                         facilityId: "5",
//                         subFacilityId: "51",
//                         name: "Ferris Wheel",
//                         rate: 25.00),
//                     Item(
//                         id: "513",
//                         facilityId: "5",
//                         subFacilityId: "51",
//                         name: "Merrigo Round",
//                         rate: 50.00)
//                   ]),
//             ]),
//         Facility(
//             id: "6",
//             name: "Swimming Pool",
//             url: "assets/images/entry.jpg",
//             description: "Swimming Pool",
//             subfacilities: [
//               SubFacility(
//                   id: "61",
//                   facilityId: "6",
//                   url: "assets/images/entry.jpg",
//                   name: "Swimming Pool",
//                   description: "Entering Ticket.",
//                   items: [
//                     Item(
//                         id: "611",
//                         facilityId: "6",
//                         subFacilityId: "61",
//                         name: "Adult",
//                         rate: 40.00),
//                     Item(
//                         id: "612",
//                         facilityId: "6",
//                         subFacilityId: "61",
//                         name: "Children",
//                         rate: 25.00),
//                     Item(
//                         id: "613",
//                         facilityId: "6",
//                         subFacilityId: "61",
//                         name: "Senior",
//                         rate: 50.00)
//                   ]),
//             ]),
//       ];
//       TicketCategoryCache.get().update(facilities);
//       return facilities;
//     });
//   }
// }
}
