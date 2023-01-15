import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/modules/settings/widgets/settingsWidgets.dart';

import '../../../constants/style.dart';
import '../../../widgets/drawer.dart';

class SettingsHomeScreen extends StatefulWidget {
  const SettingsHomeScreen({super.key});

  @override
  State<SettingsHomeScreen> createState() => _SettingsHomeScreenState();
}

class _SettingsHomeScreenState extends State<SettingsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
          style: customTextStyle(17, FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: drawer(context),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              settingTile(context, 'Profile', 'assets/icons/profile.svg',
                  ProfileScreenRoute),
              settingTile(context, 'Personal', 'assets/icons/personal.svg',
                  PersonalScreenRoute),
              settingTile(context, 'Exercise', 'assets/icons/exercise.svg',
                  ExerciseSettingsRoute),
              settingTile(
                  context, 'Mind', 'assets/icons/mind.svg', MindSettingsRoute),
              settingTile(context, 'Feedback', 'assets/icons/feedback.svg',
                  FeedbackScreenRoute),
              settingTile(context, 'Subscription',
                  'assets/icons/credit-card.svg', SubscriptionScreenRoute),
            ],
          ),
        ),
      )),
    );
  }
}
