import 'dart:convert';

import 'package:ticket_app/app/models/subfacility.dart';

class Facility {
  String id;
  String name;
  String url;
  String description;
  List<SubFacility> subfacilities = [];

  Facility(
      {required this.id,
      required this.name,
      required this.url,
      required this.description,
      required this.subfacilities});

  factory Facility.fromJson(Map<String, dynamic> jsonIn) {
    return Facility(
        id: jsonIn["id"],
        url: jsonIn["url"],
        name: jsonIn["name"],
        description: jsonIn['description'],
        subfacilities:
            _getSubFacilities(jsonIn['subfacilities'], jsonIn["id"]));
  }

  toJson() {
    return <String, dynamic>{
      "id": id,
      "url": url,
      "name": name,
      "description": description,
      "subfacilities": this.subfacilities
    };
  }

  static _getSubFacilities(List<dynamic> subfacilities, String facilityId) {
    print("$subfacilities");
    return subfacilities
        .map((e) => SubFacility.fromJson(e, facilityId))
        .toList();
  }
}
