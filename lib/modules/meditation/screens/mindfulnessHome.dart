import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/locked.dart';
import 'package:my_yellow_mind/modules/authentication/provider/authProvider.dart';
import 'package:my_yellow_mind/modules/meditation/models/meditationModel.dart';
import 'package:my_yellow_mind/modules/meditation/provider/meditationProvider.dart';
import 'package:my_yellow_mind/modules/settings/provider/subscriptionProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/routeNames.dart';
import '../../../widgets/drawer.dart';
import '../../cbt/widgets/cbtWidgets.dart';
import '../../questions/providers/questionProvider.dart';
import '../widgets/mindfulnessWidgets.dart';

class MindfulnessHomeScreen extends StatefulWidget {
  const MindfulnessHomeScreen({super.key});

  @override
  State<MindfulnessHomeScreen> createState() => _MindfulnessHomeScreenState();
}

class _MindfulnessHomeScreenState extends State<MindfulnessHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int selectedDay = DateTime.now().day;
  // generate a list of previous 7 days and reverse it
  final List<DateTime> _days = List.generate(7, (index) {
    return DateTime.now().subtract(Duration(days: index));
  }).reversed.toList();

  Future<MeditationModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    return await Provider.of<MeditationProvider>(context, listen: false)
        .getData(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          'Meditation',
          style: customTextStyle(17, FontWeight.w700),
        ),
        centerTitle: true,
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

  FutureBuilder mainScreen() {
    return FutureBuilder(
        future: getScreenData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome', style: customTextStyle(18, FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final day in _days)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDay = day.day;
                              });
                            },
                            child: Card(
                              elevation: selectedDay == day.day ? 5 : 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              shadowColor: selectedDay == day.day
                                  ? const Color(0xffE80000).withOpacity(0.16)
                                  : Colors.transparent,
                              color: selectedDay == day.day
                                  ? Colors.white
                                  : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat('E').format(day)[0],
                                      style: customTextStyle(
                                          10, FontWeight.w400,
                                          color: const Color(0xff505050)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      DateFormat('d').format(day),
                                      style:
                                          customTextStyle(10, FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                    thickness: 1,
                    indent: 150,
                    endIndent: 150,
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        statBlock('assets/icons/sleeping.png', 'Sleep',
                            '${Provider.of<MeditationProvider>(context, listen: true).moodCheckDto.sleep ?? '-'} Hours'),
                        // vertical divider
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        statBlock('assets/icons/rising.png', 'Progress',
                            '${Provider.of<MeditationProvider>(context, listen: true).moodCheckDto.progress ?? '-'} %'),
                        // vertical divider
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        statBlock('assets/icons/juggling-ball.png', 'Activity',
                            '${Provider.of<MeditationProvider>(context, listen: true).moodCheckDto.activity ?? '-'} %'),
                        // vertical divider
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        statBlock(
                            'assets/icons/dial.png',
                            'Mood',
                            Provider.of<MeditationProvider>(context,
                                        listen: true)
                                    .moodCheckDto
                                    .mood ??
                                '-'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text('Today\'s Audios',
                      style: customTextStyle(13, FontWeight.w500)),
                  const SizedBox(height: 20),
                  Consumer<MeditationProvider>(
                      builder: (context, meditationProvider, child) {
                    return Container(
                      color: Colors.transparent,
                      height: 195,
                      child: ListView.builder(
                          cacheExtent: 9999,
                          scrollDirection: Axis.horizontal,
                          itemCount: meditationProvider
                              .spUserVidAudWatchCountDtos.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MeditationPlayerRoute,
                                    arguments: meditationProvider
                                        .spUserVidAudWatchCountDtos[index]
                                        .toJson());
                              },
                              child: videoCard(
                                  meditationProvider.imagePath +
                                      meditationProvider
                                          .spUserVidAudWatchCountDtos[index]
                                          .imageFile,
                                  meditationProvider
                                      .spUserVidAudWatchCountDtos[index]
                                      .category!,
                                  meditationProvider
                                      .spUserVidAudWatchCountDtos[index]
                                      .duration!),
                            );
                          })),
                    );
                  }),
                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                    thickness: 1,
                    indent: 125,
                    endIndent: 125,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      String token =
                          Provider.of<AuthProvider>(context, listen: false)
                              .localUser
                              .token!;
                      Provider.of<QuestionProvider>(context, listen: false)
                          .getQuestions(token);
                    },
                    child: Text(
                      'Related',
                      style: customTextStyle(13, FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      cacheExtent: 9999,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: Provider.of<MeditationProvider>(context)
                          .mindCategories
                          .length,
                      itemBuilder: ((context, index) {
                        return relatedCard(
                            context,
                            Provider.of<MeditationProvider>(context)
                                .mindCategories[index]);
                      }),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Today\'s Quote',
                    style: customTextStyle(13, FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      Provider.of<MeditationProvider>(context, listen: false)
                              .qoutesDto
                              .text ??
                          '',
                      style: customTextStyle(15, FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ExpansionTile(
                    onExpansionChanged: (value) {
                      if (value) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent + 500,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    title: Text(
                      'Your live sessions',
                      style: customTextStyle(14, FontWeight.w600),
                    ),
                    children: [
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
                      Provider.of<MeditationProvider>(context, listen: false)
                              .spCBTSessionDtos
                              .isEmpty
                          ? const Center(child: Text('No live session today'))
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: Provider.of<MeditationProvider>(
                                      context,
                                      listen: false)
                                  .spCBTSessionDtos
                                  .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: liveSessionTile(
                                      context,
                                      Provider.of<MeditationProvider>(context,
                                              listen: false)
                                          .spCBTSessionDtos[index],
                                      false),
                                );
                              },
                            ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }
}
