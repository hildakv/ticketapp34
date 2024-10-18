import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ticket_app/app/models/facility.dart';
import 'package:ticket_app/app/models/ticket_item.dart';
import 'package:ticket_app/app/models/ticket_payment_details.dart';
import 'package:ticket_app/app/services/local_storage_service.dart';
import 'package:ticket_app/app/services/ticket_detail_service.dart';

// import '../../../models/category_item.dart';
import '../../../models/subfacility.dart';
import '../../../models/ticket.dart';
import '../../../utils/api_helper/network_util.dart';
import '../../../utils/global_widgets.dart';

class DashboardController extends GetxController {
  TicketDetailService _detailService = TicketDetailService();

  var _localStorage = LocalStorageService.instance();

  List<Facility> facilities = [];

  late SubFacility currentSubFacility;

  late Facility currentFacility;

  bool isLoadingDashboard = false;

  String _appVersion = 'Version: N/A';
  // List<SubFacility> subCategoryItems = [];
  // List<CategoryItem> categoryItems = [];

  // late CategoryItem currentItem;

  GlobalKey<ExpandableBottomSheetState> cart_key = new GlobalKey();

  // TicketPaymentDetails ticketPaymentDetails = TicketPaymentDetails();

  Map<String, TicketPaymentDetails> paymentDetails = {};

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("*******************************#######");
    // this._detailService.getFacilities().then((value) {
    TicketDetailService.getFacilities().then((value) {
      print("******************************* $value");
      facilities = value;
      update();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCurrentSubFacility(SubFacility subFacility) {
    this.currentSubFacility = subFacility;
    update();
  }

  void updatePayementDetails(String subFacilityId, List<TicketItem> items) {
    if (!this.paymentDetails.containsKey(this.currentFacility.id)) {
      this.paymentDetails[this.currentFacility.id] = new TicketPaymentDetails();
    }
    this.paymentDetails[this.currentFacility.id]?.update(subFacilityId, items);
    update();
  }

  void updateTicket(TicketItem item) {
    if (!this.paymentDetails.containsKey(item.facilityId)) {
      this.paymentDetails[item.facilityId] = new TicketPaymentDetails();
    }
    this.paymentDetails[item.facilityId]?.update(item.subFacilityId, [item]);
    update();
  }

  int getItemCount(String subFacilityId, String itemId) {
    if (this.paymentDetails.containsKey(this.currentFacility.id)) {
      return this
              .paymentDetails[this.currentFacility.id]
              ?.getItemCount(subFacilityId, itemId) ??
          0;
    } else {
      return 0;
    }
  }

  Ticket generateTicket() {
    var ticket = Ticket(
        id: "id",
        details: this.paymentDetails,
        total: this.getTotalPaymentAmount());
    _localStorage.saveTicket(ticket);
    return ticket;
  }

  int getTotalItemCount() {
    // var paymentDetails = getCurrentPaymentDetails();
    // if (null == paymentDetails) {
    //   return 0;
    // }

    int count = 0;

    this.paymentDetails.entries.forEach((facility) {
      facility.value.items.entries.forEach((detail) {
        detail.value.entries.forEach((item) {
          count += item.value.count;
        });
      });
    });

    // paymentDetails.items.entries.forEach((element) {
    //   element.value.entries.forEach((element) {
    //     count += element.value.count;
    //   });
    // });

    return count;
  }

  double getTotalPaymentAmount() {
    double amount = 0.0;
    this.paymentDetails.entries.forEach((facility) {
      facility.value.items.entries.forEach((detail) {
        detail.value.entries.forEach((item) {
          amount += (item.value.count * item.value.rate);
        });
      });
    });

    return amount;
    // var paymentDetails = getCurrentPaymentDetails();
    // if (null == paymentDetails) {
    //   return 0;
    // }

    // double amount = 0.0;

    // paymentDetails.items.entries.forEach((element) {
    //   element.value.entries.forEach((element) {
    //     amount += (element.value.count * element.value.rate);
    //   });
    // });

    // return amount;
  }

  TicketPaymentDetails? getCurrentPaymentDetails() {
    return this.paymentDetails[this.currentFacility.id];
  }

  void clearPaymentDetails() {
    this.paymentDetails.clear();
    update();
  }

  Future<void> loadData() async {
    try {
      final hasConnection = await DataConnectionChecker().hasConnection;
      if (!hasConnection) {
        showSnackBar(
          type: SnackbarType.warning,
          message: 'No internet connection',
        );
      }

      isLoadingDashboard = true;

      // final dashboardProgresRes = await DashboardServices.dashboardProgress();

      // dashboardProgresRes.fold(
      //   (l) => showSnackBar(
      //     type: SnackbarType.error,
      //     message: l,
      //   ),
      //   (r) => {
      //     target = r['target'].toString(),
      //     achievement = r['achievement'].toString(),
      //     unitIdentified = r['unit_identified'].toString(),
      //     achievementRatio = r['achievement_ratio'].toString(),
      //     ratio = r['ratio'].toString(),
      //     investement = r['investement'].toString(),
      //     employementGenerated = r['employement_generated'].toString(),
      //   },
      // );

      isLoadingDashboard = false;
    } catch (e, s) {
      // if (kDebugMode) rethrow;
      // FirebaseCrashlytics.instance.recordError(e, s);
      isLoadingDashboard = false;
    }
  }
}
