import 'package:json_annotation/json_annotation.dart';

part "ticket_item.g.dart";

@JsonSerializable()
class TicketItem {
  String itemId;

  String facilityId;

  String subFacilityId;

  String name;

  late int count = 0;

  double rate;

  TicketItem(
      {required this.itemId,
      required this.name,
      required this.rate,
      required this.facilityId,
      required this.subFacilityId,
      this.count = 0});

  String toString() {
    return "${itemId} -> { ${name} | $count }";
  }

  factory TicketItem.fromJson(Map<String, dynamic> json) =>
      _$TicketItemFromJson(json);

  toJson() => _$TicketItemToJson(this);
}
