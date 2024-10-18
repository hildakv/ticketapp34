import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:pinelab_sdk/pinelab_sdk.dart';
import 'package:ticket_app/app/models/pinelabs/pinelabs_detail_response.dart';
import 'package:ticket_app/app/utils/cache/ticket_category_cache.dart';

import '../models/ticket.dart';
import '../models/ticket_payment_details.dart';

class PineLabsPaymentService {
  final pinelabSdk = PinelabSdk();
  final cache = TicketCategoryCache.get();
  static final PineLabsPaymentService paymentService = PineLabsPaymentService();

  Future<PinelabResponse> doCardPayment(final double total) async {
    Completer<PinelabResponse> completer = Completer();
    try {
      var transactionMap = {
        'Detail': {
          'BillingRefNo': 'TX12345678',
          'PaymentAmount': total * 100,
          'TransactionType': 4001,
        },
        'Header': {
          'ApplicationId': 'de619e9d395444efb6952db5b66f4e5e',
          'MethodId': '1001',
          'UserId': '1234',
          'VersionNo': '1.0',
        },
      };
      final doTransactionPayload = jsonEncode(transactionMap);

      pinelabSdk.startTransaction(transactionRequest: doTransactionPayload);
      pinelabSdk.streamController.stream.listen((event) {
        completer.complete(event);
      });
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<PinelabResponse> doCashPayment(Ticket ticket) {
    // print(details);
    return printTicket(ticket);
  }

  Future<PinelabResponse> printTicket(Ticket ticket) {
    String data = _generatePrintDataAll(ticket);
    Completer<PinelabResponse> completer = Completer();
    try {
      var transactionMap = {
        'Detail': {
          'PrintRefNo': 'TX12345678',
          "Data": [
            {
              "PrintDataType": "0",
              "PrinterWidth": 32,
              "IsCenterAligned": true,
              "DataToPrint": data,
              "ImagePath": "0",
              "ImageData": "0"
            },
            {
              "PrintDataType": "4",
              "PrinterWidth": 32,
              "IsCenterAligned": true,
              "DataToPrint": data,
              "ImagePath": "0",
              "ImageData": "0"
            }
          ],
        },
        'Header': {
          'ApplicationId': 'de619e9d395444efb6952db5b66f4e5e',
          'MethodId': '1002',
          'UserId': '1234',
          'VersionNo': '1.0',
        },
      };
      final doTransactionPayload = jsonEncode(transactionMap);

      pinelabSdk.startTransaction(transactionRequest: doTransactionPayload);
      pinelabSdk.streamController.stream.listen((event) {
        var response = event as PinelabResponse;
        var detailResponse =
            PineLabsDetailResponse.fromJson(jsonDecode(response.response));
        if (response.isSuccess && detailResponse.response?.responseCode == 0) {
          completer.complete(event);
        } else {
          completer.completeError(detailResponse);
        }
        print(event);
      });
      // completer.complete(PinelabResponse(isSuccess: true, response: ""));
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  String _generatePrintDataAll(Ticket ticket) {
    int size = 32;
    String data = "";
    data += _generatePrintHeader(size);
    var ticketDetails = ticket.details;
    ticketDetails.entries.forEach((facility) {
      data += "\n";
      data += cache.getFacilityName(facility.key);
      data += _generatePrintData(facility.value);
    });

    data += _generatePrintFooter(ticket.total, size);

    print("**************************************************");
    print(data);
    print("**************************************************");

    return data;
  }

  String _generatePrintHeader(int size) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String data = dateFormat.format(DateTime.now());
    data += "\n";
    data += "-" * size;
    data += "\n";

    // total -> 9999 (6)
    // rate -> 999(5)
    // qty -> 99 (4)
    // category -> (17)
    data += "Facility         Qty Rate Total \n";
    // data += "----------------------------------";
    data += "-" * size;
    return data;
  }

  String _generatePrintFooter(totalAmount, size) {
    String data = "\n";
    data += "-" * size;
    data += "\n";
    data += _padLeft("Total Amount: ${totalAmount}", size);
    return data;
  }

  String _generatePrintData(TicketPaymentDetails details) {
    // print(details);
    // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    // String data = dateFormat.format(DateTime.now());
    // data += "\n------------------------";
    // data += "\n";

    // // total -> 9999 (6)
    // // rate -> 999(5)
    // // qty -> 99 (4)
    // // category -> (17)
    // data += "Facility         Qty Rate Total \n";
    // data += "----------------------------------";
    String data = "";
    details.items.forEach((key, value) {
      var subfacility = cache.getSubFacilityName(key);
      // data = _append(data, category);
      value.forEach((key, value) {
        if (value.count > 0) {
          String line = _padRight("$subfacility" + value.name, 7);
          line += _padRight(value.name, 10);
          line += _padRight("${value.count}", 4);
          line += _padRight("${value.rate.toInt()}", 5);
          line += _padRight("${(value.rate * value.count).toInt()}", 6);
          // line += "${value.count} ${value.rate} ${value.rate * value.count}";
          data = _append(data, line);
        }
      });
    });

    // data += "\n------------------------\n";
    // data += _padLeft("Total Amount: ${details.totalAmount}", 24);
    // print("**************************************************");
    // print(data);
    // print("**************************************************");
    return data;
  }

  String _padRight(String str, int size) {
    if (str.length >= size) {
      return str.substring(0, size - 1);
    }
    return str.padRight(size, ' ');
  }

  String _padLeft(String str, int size) {
    return str.padLeft(size - str.length, ' ');
  }

  String _append(String str, String toAppend) {
    return "$str\n$toAppend";
  }

  String _prepend(String str, String toPrepend) {
    return "$toPrepend\n$str";
  }

  String getCartTickets(TicketPaymentDetails details) {
    String data = "\n";
    String heading = "";
    heading += _padRight("Item", 40);
    heading += _padLeft("Qty", 15);
    heading += _padLeft("Rate", 15);
    heading += _padLeft("Total", 20);
    // heading += _repeatString("*", 75);
    String br = '-' * 75;
    heading = _append(heading, br);
    // heading += "ItemQty       Rate      Total \n";
    // heading += "----------------------------------";
    details.items.forEach((key, value) {
      var category = cache.getSubFacilityName(key);
      // data = _append(data, category);
      value.forEach((key, value) {
        if (value.count > 0) {
          String line = _padRight("$category", 20);
          line += _padRight(value.name, 20);
          line += _padRight("${value.count}", 15);
          line += _padRight("${value.rate.toInt()}", 15);
          line += _padRight("${(value.rate * value.count).toInt()}", 20);
          // line += "${value.count} ${value.rate} ${value.rate * value.count}";
          data = _prepend(data, line);
        }
      });
    });
    return _append(heading, data);
  }
}
