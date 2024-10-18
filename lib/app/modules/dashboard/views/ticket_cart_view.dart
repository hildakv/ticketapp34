import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticket_app/app/modules/dashboard/views/widgets/ticket_cart.dart';

import '../../../utils/widgets/text_ex.dart';

class TicketCartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextEx(
          "Payments",
          fontSize: 24,
        ),
      ),
      body: Container(
        child: TicketCart(
          subFacilityBackground: Colors.brown.shade100,
          itemsBackground: Colors.blueGrey.shade300,
          bottomBarBackground: Colors.brown.shade300,
          onClicked: () {},
        ),
      ),
    );
  }
}
