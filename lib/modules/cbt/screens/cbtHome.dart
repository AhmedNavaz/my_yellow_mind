import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/cbt/models/cbtsessionModel.dart';
import 'package:provider/provider.dart';

import '../../../locked.dart';
import '../../../widgets/drawer.dart';
import '../../authentication/provider/authProvider.dart';
import '../../settings/provider/subscriptionProvider.dart';
import '../providers/cbtProvider.dart';
import '../widgets/cbtWidgets.dart';

class CBTHomeScreen extends StatefulWidget {
  const CBTHomeScreen({super.key});

  @override
  State<CBTHomeScreen> createState() => _CBTHomeScreenState();
}

class _CBTHomeScreenState extends State<CBTHomeScreen> {
  List<String> options = [
    'Little bit 😕',
    'Extremely 🙂',
    'Very Extremely 🤩',
  ];
  int selected = -1;

  List<SpCBTSessionDtos> sessions = [];

  Future<void> getData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    sessions = await Provider.of<CBTProvider>(context, listen: false)
        .getCbtSessions(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CBT',
          style: customTextStyle(17, FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: drawer(context),
      body: Provider.of<SubscriptionProvider>(context, listen: true).freeTrial
          ? mainScreen()
          : Stack(
              children: [
                mainScreen(),
                const LockedFeatures(),
              ],
            ),
    );
  }

  SingleChildScrollView mainScreen() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            children: [
              Text(
                'Your live session today',
                style: customTextStyle(13, FontWeight.w500),
              ),
              const Spacer(),
              Column(
                children: [
                  Text('Live',
                      style: customTextStyle(11, FontWeight.w700,
                          color: const Color(0xff3154FF))),
                  SvgPicture.asset('assets/icons/live.svg')
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return sessions.isEmpty
                    ? const Center(child: Text('No live session today'))
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child:
                                liveSessionTile(context, sessions[index], true),
                          );
                        },
                      );
              }),
          const SizedBox(height: 20),
        ],
      ),
    ));
  }
}
