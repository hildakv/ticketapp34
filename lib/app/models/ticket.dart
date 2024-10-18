import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:ticket_app/app/models/ticket_payment_details.dart';

part "ticket.g.dart";

@JsonSerializable()
class Ticket {
  String id;

  double total;

  Map<String, TicketPaymentDetails> details;

  TicketStatus status;

  Ticket(
      {required this.id,
      required this.details,
      required this.total,
      this.status = TicketStatus.CREATED});

  toJson() => _$TicketToJson(this);

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
}

enum TicketStatus {
  CREATED,
  PAID,
  PRINTED,
  COMPLETED;

  toJson() {
    return name;
  }

  static TicketStatus fromJson(String json) {
    return values.byName(json);
  }
}
