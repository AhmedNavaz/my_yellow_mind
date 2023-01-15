import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/style.dart';

class SmartWatchStats extends StatefulWidget {
  SmartWatchStats({super.key, required this.data});

  Map<String, dynamic> data;

  @override
  State<SmartWatchStats> createState() => _SmartWatchStatsState();
}

class _SmartWatchStatsState extends State<SmartWatchStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              Center(
                  child: Text('Today',
                      style: customTextStyle(15, FontWeight.w500))),
              const SizedBox(height: 30),
              Card(
                child: ListTile(
                  leading: Image.asset(
                    widget.data['icon'],
                    height: 50,
                    width: 50,
                  ),
                  title: Text(
                    widget.data['title'],
                    style: customTextStyle(11, FontWeight.w600),
                  ),
                  subtitle: Text('Connected',
                      style: customTextStyle(8, FontWeight.w500)),
                  trailing:
                      Text('80 %', style: customTextStyle(12, FontWeight.w500)),
                ),
              ),
              const SizedBox(height: 40),
              watchStatsTile('Sleep', 'assets/icons/moon.svg', 7, 14, 80),
              const SizedBox(height: 40),
              watchStatsTile('Steps', 'assets/icons/footsteps.svg', 1, 15, 20),
            ],
          ),
        ),
      ),
    );
  }

  Column watchStatsTile(
      String title, String icon, int hour, int min, double completedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: customTextStyle(13, FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Column(children: [
              SvgPicture.asset(icon),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: '$hour',
                  style: customTextStyle(16, FontWeight.w600),
                ),
                TextSpan(
                  text: ' hr ',
                  style: customTextStyle(13, FontWeight.w500),
                ),
                TextSpan(
                  text: '$min',
                  style: customTextStyle(16, FontWeight.w600),
                ),
                TextSpan(
                  text: ' mins',
                  style: customTextStyle(13, FontWeight.w500),
                ),
              ]))
            ]),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: completedValue / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(Colors.red),
                    minHeight: 5,
                  ),
                  const SizedBox(height: 12.5),
                  LinearProgressIndicator(
                    value: 1 - completedValue / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(Colors.black54),
                    minHeight: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(children: [
              Text('Completed',
                  style: customTextStyle(11, FontWeight.w500,
                      color: const Color(0xff707070))),
              const SizedBox(height: 5),
              Text('Remaining',
                  style: customTextStyle(11, FontWeight.w500,
                      color: const Color(0xff707070))),
            ]),
          ],
        ),
      ],
    );
  }
}
