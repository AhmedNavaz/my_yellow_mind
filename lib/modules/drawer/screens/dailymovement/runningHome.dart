import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:provider/provider.dart';

import '../../../../constants/style.dart';
import '../../../authentication/provider/authProvider.dart';
import '../../models/dailyMovementModel.dart';
import '../../providers/dailyMovementProvider.dart';
import '../../widgets/dailyMovementWidgets.dart';

class RunningHomeScreen extends StatefulWidget {
  const RunningHomeScreen({super.key});

  @override
  State<RunningHomeScreen> createState() => _RunningHomeScreenState();
}

class _RunningHomeScreenState extends State<RunningHomeScreen> {
  Future<DailyMovementModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    return await Provider.of<DailyMovementProvider>(context, listen: false)
        .getData(token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getScreenData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Top Plans',
                    style: customTextStyle(16, FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  Consumer<DailyMovementProvider>(
                      builder: (context, meditationProvider, index) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: meditationProvider.runningPlansList.length,
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.withOpacity(0.5),
                              thickness: 1,
                              indent: 150,
                              endIndent: 150,
                              height: 50,
                            ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, TimerScreenRoute,
                                  arguments: meditationProvider
                                      .exerciseDtos[index].duration);
                            },
                            child: meditationPlanTile(
                              context,
                              meditationProvider.exerciseDtos[index].title!,
                              meditationProvider.imagePath +
                                  meditationProvider
                                      .exerciseDtos[index].fileName!,
                              meditationProvider.exerciseDtos[index].duration!,
                            ),
                          );
                        });
                  }),
                ],
              ),
            ),
          );
        });
  }
}
