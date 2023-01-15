import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/drawer/providers/dailyMovementProvider.dart';
import 'package:provider/provider.dart';

import '../../../../constants/routeNames.dart';
import '../../../authentication/provider/authProvider.dart';
import '../../widgets/dailyMovementWidgets.dart';

class YogaHomeScreen extends StatefulWidget {
  const YogaHomeScreen({super.key});

  @override
  State<YogaHomeScreen> createState() => _YogaHomeScreenState();
}

class _YogaHomeScreenState extends State<YogaHomeScreen> {
  Future<void> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    await Provider.of<DailyMovementProvider>(context, listen: false)
        .getYoga(token);
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
                      builder: (context, yogaProvider, index) {
                    return ListView.separated(
                        cacheExtent: 9999,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: yogaProvider.yogaList.length,
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
                              Navigator.pushNamed(context, MediaPlayerRoute,
                                  arguments:
                                      yogaProvider.yogaList[index].toJson());
                            },
                            child: yogaPlanTile(
                              context,
                              yogaProvider.yogaList[index].title!,
                              yogaProvider.imagePath +
                                  yogaProvider.yogaList[index].imageFile!,
                              yogaProvider.yogaList[index].duration!,
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
