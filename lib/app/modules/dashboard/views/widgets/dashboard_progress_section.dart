import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_app/app/modules/dashboard/controllers/dashboard_controller.dart';
// import 'package:line_icons/line_icons.dart';

import '../../../../routes/app_pages.dart';
import '../../../../utils/general_utils.dart';
import '../../../../utils/global_widgets.dart';
// import '../../controllers/home_controller.dart';
// import 'unit_progress_card.dart';

class DashboardProgressSection extends StatelessWidget {
  const DashboardProgressSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HEIGHT_12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const Text('Progress', style: TextStyle(fontSize: 18)),
              RichText(
                text: TextSpan(
                  text: 'Progress',
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 17,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {}, //=> Get.toNamed(Routes.UNITS_DASHBOARD),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    Text('View Details'),
                    SizedBox(width: 6),
                    // Icon(LineIcons.arrowRight, size: 18),
                  ],
                ),
              ),
            ],
          ),
          Row(),
        ],
      ),
    );
  }
}
