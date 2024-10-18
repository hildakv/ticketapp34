import 'dart:ffi';

import 'package:ticket_app/app/models/subfacility.dart';

class Item {
  String id;

  String facilityId;

  String subFacilityId;

  String name;

  String description;

  double rate;

  int max;

  Item(
      {required this.id,
      required this.name,
      required this.rate,
      required this.facilityId,
      required this.subFacilityId,
      this.description = "",
      this.max = 100});
  String toString() {
    return this.name;
  }

  factory Item.fromJson(Map<String, dynamic> jsonIn, SubFacility subFacility) {
    return Item(
        id: jsonIn["id"],
        facilityId: jsonIn["facilityId"] ?? subFacility.facilityId,
        subFacilityId: jsonIn["subFacilityId"] ?? subFacility.id,
        name: jsonIn["name"],
        description: jsonIn["description"] ?? '',
        rate: (jsonIn["rate"] is String)
            ? double.parse(jsonIn["rate"])
            : jsonIn["rate"],
        // max: int.parse(jsonIn['max'] ?? '0'));
        max: 0);
    // max: (jsonIn['max'] is String)
    //     ? int.parse(jsonIn['max'])
    //     : jsonIn['max'] ?? '0');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facilityId'] = facilityId;
    data['subFacilityId'] = subFacilityId;
    data['name'] = name;
    data['description'] = description;
    data['rate'] = rate;
    data['max'] = max;
    return data;
  }
}
