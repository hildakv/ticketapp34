import 'package:ticket_app/app/models/ticket_item.dart';

import 'package:json_annotation/json_annotation.dart';

part "ticket_payment_details.g.dart";

@JsonSerializable()
class TicketPaymentDetails {
  // static var _instance = TicketPaymentDetails();

  double totalAmount = 0.0;

  // [subfacilityid, [itemid, item]]
  Map<String, Map<String, TicketItem>> items = {};

  TicketPaymentDetails();

  update(String subFacilityId, List<TicketItem> ticketItems) {
    ticketItems.forEach((element) {
      _update(subFacilityId, element);
    });

    _caculateTotal();
    _print();
  }

  _print() {
    print("************************ $items");
  }

  _update(String subFacilityId, TicketItem item) {
    if (item.count <= 0) {
      _remove(subFacilityId, item);
    } else {
      items.update(subFacilityId, (value) {
        value.update(item.itemId, (value) => item, ifAbsent: () => item);
        return value;
      }, ifAbsent: () {
        Map<String, TicketItem> it = {};
        it.putIfAbsent(item.itemId, () => item);
        return it;
      });
    }
    // var categories = items[categoryId];
    // if (categories == null) {
    //   categories = {};
    //   categories.putIfAbsent(categoryId, () => item);
    //   items[categoryId] = categories;
    //   return;
    // }
    //
    // var categoryItem = categories[item.itemId];
    // if (null == categoryItem) {
    //   categories[item.itemId] = item;
    // } else {
    //   categoryItem.count = item.count;
    // }
  }

  _remove(String subFacilityId, TicketItem item) {
    items[subFacilityId]?.remove(item.itemId);
  }

  clear() {
    this.items = {};
    this.totalAmount = 0;
  }

  getItemCount(subFacilityId, itemId) {
    var count = items[subFacilityId]?[itemId]?.count;
    print("item count: $subFacilityId -> $itemId ----> $count");
    return count;
  }

  _caculateTotal() {
    double total = 0.0;
    items.forEach((key, value) {
      value.forEach((key, item) {
        total += (item.count * item.rate);
      });
    });
    this.totalAmount = total;
  }

  factory TicketPaymentDetails.get() {
    return TicketPaymentDetails();
  }

  factory TicketPaymentDetails.fromJson(Map<String, dynamic> json) =>
      _$TicketPaymentDetailsFromJson(json);

  toJson() => _$TicketPaymentDetailsToJson(this);
}
