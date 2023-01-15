import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/drawer/screens/dailymovement/runningHome.dart';
import 'package:my_yellow_mind/modules/drawer/screens/dailymovement/yogaHome.dart';

import '../../../../constants/style.dart';

class DailyMovementHomeScreen extends StatefulWidget {
  const DailyMovementHomeScreen({super.key});

  @override
  State<DailyMovementHomeScreen> createState() =>
      _DailyMovementHomeScreenState();
}

class _DailyMovementHomeScreenState extends State<DailyMovementHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: TabBar(
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: Text(
                  'Yoga',
                  style: customTextStyle(13, FontWeight.w600),
                ),
              ),
              Tab(
                child: Text(
                  'Running',
                  style: customTextStyle(13, FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [YogaHomeScreen(), RunningHomeScreen()],
        ),
      ),
    );
  }
}
