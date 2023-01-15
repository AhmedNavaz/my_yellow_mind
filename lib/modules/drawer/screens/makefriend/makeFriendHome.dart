import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants/routeNames.dart';
import '../../../../constants/style.dart';
import '../../../../locked.dart';
import '../../../authentication/provider/authProvider.dart';
import '../../../settings/provider/subscriptionProvider.dart';
import '../../models/buddyModel.dart';
import '../../providers/budyyProvider.dart';
import '../../widgets/makeFriendWidget.dart';

class MakeFriendHomeScreen extends StatefulWidget {
  const MakeFriendHomeScreen({super.key});

  @override
  State<MakeFriendHomeScreen> createState() => _MakeFriendHomeScreenState();
}

class _MakeFriendHomeScreenState extends State<MakeFriendHomeScreen> {
  bool viewMore = false;

  Future<BuddyModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    return await Provider.of<BuddyProvider>(context, listen: false)
        .getData(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find new buddies across the world',
          style: customTextStyle(17, FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(child: Image.asset('assets/images/make-friend.png')),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Text(
                        'Suggestions',
                        style: customTextStyle(17, FontWeight.w600),
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/filter.svg')
                    ],
                  ),
                  const SizedBox(height: 20),
                  Consumer<BuddyProvider>(
                      builder: (context, buddyProvider, child) {
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            viewMore ? buddyProvider.all_users.length : 4,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, ChatScreenRoute,
                                  arguments:
                                      buddyProvider.all_users[index].toJson());
                            },
                            child: friendTile(
                                context,
                                buddyProvider.all_users[index].userId!,
                                buddyProvider.all_users[index].name!,
                                buddyProvider.all_users[index].name!,
                                3, () {
                              setState(() {});
                            }),
                          );
                        });
                  }),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          viewMore = !viewMore;
                        });
                      },
                      child: Text(
                        viewMore ? 'View less' : 'View more',
                        style: customTextStyle(12, FontWeight.w600,
                            color: const Color(0xff6C89FB)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
