// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketItem _$TicketItemFromJson(Map<String, dynamic> json) => TicketItem(
      itemId: json['itemId'] as String,
      name: json['name'] as String,
      rate: (json['rate'] as num).toDouble(),
      facilityId: json['facilityId'] as String,
      subFacilityId: json['subFacilityId'] as String,
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$TicketItemToJson(TicketItem instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'facilityId': instance.facilityId,
      'subFacilityId': instance.subFacilityId,
      'name': instance.name,
      'count': instance.count,
      'rate': instance.rate,
    };
