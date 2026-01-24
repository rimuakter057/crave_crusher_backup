// ignore_for_file: unused_local_variable

import 'package:crave_crusher/helper/time_converter/date_converter.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/widget/log_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BattleLogScreen extends StatelessWidget {
  final String battleId;
  final BattleController controller = Get.find<BattleController>();

  BattleLogScreen({super.key, required this.battleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Battle Log', actions: []),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Obx(() {
          final battleLogs = controller.battleDetails.value.battleLogs;

          if (battleLogs == null || battleLogs.isEmpty) {
            return EmptyWidget(title: "No battle history yet.");
          }
          final dateConverter = DateConverter();
          return Column(
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: battleLogs.length,
                  itemBuilder: (context, index) {
                    final log = battleLogs[index];
                    final type = getLogTypeFromStatus(log.status ?? '');
                    return LogEntryItem(
                      type: type,
                      dayNumber: log.day ?? 0,
                      countCaved: log.totalCaved??0,
                      countCraved:  log.totalCraved??0,
                      timestamp: DateConverter.dateYearTimeUtc(
                        log.createdAt ?? '',
                      ),




                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
