// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
    id: json['id'] as String,
    details: (json['details'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, TicketPaymentDetails.fromJson(e as Map<String, dynamic>)),
    ),
    total: (json['total'] as num).toDouble(),
    status: TicketStatus.fromJson(json['status']));

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'details': instance.details,
      'status': instance.status
    };
