import 'dart:convert';

import 'package:ticket_app/app/models/item.dart';

class SubFacility {
  String id;

  String facilityId;

  String url;

  String name;

  String description;

  List<Item> items = [];

  SubFacility(
      {required this.id,
      required this.facilityId,
      required this.url,
      required this.name,
      required this.description,
      this.items = const []});

  String toString() {
    return this.name;
  }

  factory SubFacility.fromJson(Map<String, dynamic> jsonIn, String facilityId) {
    var subFacility = SubFacility(
        id: jsonIn["id"],
        facilityId: jsonIn["facilityId"] ?? facilityId,
        url: jsonIn["url"],
        name: jsonIn["name"],
        description: jsonIn['description'] ?? "");
    subFacility.items = _getItems(jsonIn["items"], subFacility);
    return subFacility;
  }

  static _getItems(List<dynamic> items, SubFacility subFacility) {
    return items.map((e) => Item.fromJson(e, subFacility)).toList();
  }

  toJson() {
    return <String, dynamic>{
      'id': id,
      'facilityId': facilityId,
      'url': url,
      'name': name,
      'description': description,
      'items': items
    };
  }
}
