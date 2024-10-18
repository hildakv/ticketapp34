import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_cart.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_cart_bar.dart';

import '../../../../utils/theme_data.dart';
import '../../controllers/dashboard_controller.dart';

class CartViewWidget extends StatelessWidget {
  // const CartViewWidget({super.key});
  final PanelController panelController = PanelController();

  final Widget widget;

  CartViewWidget({required this.widget});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) {
        return _getBody(_);
      },
    );
  }

  _getBody(DashboardController _) {
    double totalAmount = _.getTotalPaymentAmount();
    var theme = ticketCartTheme1;
    print("888888888888888888888888888888888 --> $totalAmount");
    if (totalAmount <= 0.0) {
      return widget;
    } else {
      return SlidingUpPanel(
        controller: panelController,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        borderRadius: BorderRadius.circular(5),
        color: theme.panelBackground,
        padding: EdgeInsets.all(5),
        backdropEnabled: true,
        minHeight: 100,
        // panel: TextField(),
        panel: TicketCart(
          subFacilityBackground: theme.subFacilityBackground,
          itemsBackground: theme.itemsBackground,
          bottomBarBackground: theme.bottomBarBackground,
          onClicked: () {
            if (this.panelController.isPanelClosed) {
              this.panelController.open();
            }
          },
        ),
        body: KeyboardDismisser(
            gestures: [GestureType.onTap],
            child:
                Padding(padding: EdgeInsets.only(bottom: 200), child: widget)),
        collapsed: TicketCartBar(
          onClicked: () {
            if (this.panelController.isPanelClosed) {
              this.panelController.open();
            }
          },
          isPay: false,
          backGroundColor: Color.fromRGBO(238, 241, 255, 1),
        ),
      );
    }
  }
}
