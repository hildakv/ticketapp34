// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_payment_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketPaymentDetails _$TicketPaymentDetailsFromJson(
        Map<String, dynamic> json) =>
    TicketPaymentDetails()
      ..totalAmount = (json['totalAmount'] as num).toDouble()
      ..items = (json['items'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) =>
                  MapEntry(k, TicketItem.fromJson(e as Map<String, dynamic>)),
            )),
      );

Map<String, dynamic> _$TicketPaymentDetailsToJson(
        TicketPaymentDetails instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'items': instance.items,
    };
