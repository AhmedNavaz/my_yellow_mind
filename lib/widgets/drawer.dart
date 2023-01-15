import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/routeNames.dart';
import '../constants/style.dart';
import '../modules/authentication/provider/authProvider.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
      child: Column(children: [
    const SizedBox(height: 50),
    ListTile(
      leading: Image.asset('assets/icons/drawer/motivational.png'),
      title: Text(
        'Motivation',
        style: customTextStyle(16, FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, MotivationRoute);
      },
    ),
    ListTile(
      leading: Image.asset('assets/icons/drawer/moodcheck.png',
          width: 20, height: 20),
      title: Text(
        'Mood Check',
        style: customTextStyle(16, FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, MoodCheckRoute);
      },
    ),
    ListTile(
      leading: Image.asset('assets/icons/drawer/soothing.png'),
      title: Text(
        'Soothing Sound',
        style: customTextStyle(16, FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, SoothingSoundRoute);
      },
    ),
    ListTile(
      leading: Image.asset('assets/icons/drawer/ai.png'),
      title: Text(
        'AI Friend(Poko)',
        style: customTextStyle(16, FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, AIFriendRoute);
      },
    ),
    ListTile(
      leading: Image.asset('assets/icons/drawer/buddy.png'),
      title: Text(
        'Make Friend',
        style: customTextStyle(16, FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, MakeFriendRoute);
      },
    ),
    // ListTile(
    //   leading: Image.asset('assets/icons/drawer/watch.png'),
    //   title: Text(
    //     'Smart Watch Connect',
    //     style: customTextStyle(16, FontWeight.w500),
    //   ),
    //   onTap: () {
    //     Navigator.pop(context);
    //     Navigator.pushNamed(context, SmartWatchRoute);
    //   },
    // ),
    ListTile(
      leading: Image.asset('assets/icons/drawer/movement.png',
          width: 20, height: 20),
      title: Text(
        'Daily Movement',
        style: customTextStyle(16, FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, DailyMovementRoute);
      },
    ),
    ListTile(
      leading:
          Image.asset('assets/icons/drawer/logout.png', width: 20, height: 20),
      title: Text(
        'Log Out',
        style: customTextStyle(16, FontWeight.w500),
      ),
      onTap: () async {
        Navigator.pop(context);
        Provider.of<AuthProvider>(context, listen: false).signOut();
        Navigator.pushNamedAndRemoveUntil(
            context, LoginRoute, (Route<dynamic> route) => false);
      },
    ),
  ]));
}
