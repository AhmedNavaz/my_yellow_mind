import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';

import '../../../../constants/style.dart';

class SmartWatchScreen extends StatefulWidget {
  const SmartWatchScreen({super.key});

  @override
  State<SmartWatchScreen> createState() => _SmartWatchScreenState();
}

class _SmartWatchScreenState extends State<SmartWatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smart Watch',
          style: customTextStyle(17, FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text('Recent Connection',
                  style: customTextStyle(13, FontWeight.w300)),
              const SizedBox(height: 20),
              smartWatchTile(
                  context, 'Google Fit', 'assets/icons/watches/google-fit.png'),
              smartWatchTile(
                  context, 'Apple Watch', 'assets/icons/watches/apple.png'),
              smartWatchTile(context, 'Samsung Health',
                  'assets/icons/watches/samsung-health.png'),
              smartWatchTile(
                  context, 'Fitbit', 'assets/icons/watches/fitbit.png'),
            ],
          ),
        ),
      ),
    );
  }
}

ListTile smartWatchTile(BuildContext context, String title, String icon) {
  return ListTile(
    leading: Image.asset(
      icon,
      height: 30,
      width: 30,
    ),
    title: Text(
      title,
      style: customTextStyle(12, FontWeight.w500),
    ),
    trailing: IconButton(
      onPressed: () {
        Navigator.pushNamed(context, SmartWatchStatsRoute, arguments: {
          'title': title,
          'icon': icon,
        });
      },
      icon: const Icon(Icons.settings),
    ),
  );
}
