import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/sleep/models/sleepModel.dart';
import 'package:provider/provider.dart';

import '../../../constants/routeNames.dart';
import '../providers/sleepProvider.dart';
import '../widgets/sleepWidgets.dart';

class SleepCategoriesScreen extends StatefulWidget {
  SleepCategoriesScreen({super.key, required this.sleepData});

  Map<String, dynamic> sleepData;

  @override
  State<SleepCategoriesScreen> createState() => _SleepCategoriesScreenState();
}

class _SleepCategoriesScreenState extends State<SleepCategoriesScreen> {
  List<SpUserVidAudWatchCountDtos> sleepMusic = [];

  @override
  void initState() {
    String temp = 'Sleep stories';
    if (widget.sleepData['name'] != temp) {
      temp = 'sleep';
    }
    Provider.of<SleepProvider>(context, listen: false)
        .getCategoryData(temp)
        .then((value) {
      setState(() {
        sleepMusic = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.sleepData['name'],
                  style: customTextStyle(17, FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                            Provider.of<SleepProvider>(context, listen: false)
                                    .imagePath +
                                widget.sleepData['imageName']),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.sleepData['name'],
                  style: customTextStyle(12, FontWeight.w500,
                      color: Colors.black.withOpacity(0.74)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Music for you',
                style: customTextStyle(15, FontWeight.w500),
              ),
              const SizedBox(height: 20),
              sleepMusic.isEmpty
                  ? Center(
                      child: Text(
                        'Nothing in this category right now!',
                        style: customTextStyle(12, FontWeight.w400,
                            color: Colors.grey),
                      ),
                    )
                  : Column(children: [
                      for (int i = 0; i < sleepMusic.length; i++)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MediaPlayerRoute,
                                    arguments: sleepMusic[i].toJson())
                                .then((value) {
                              setState(() {});
                            });
                          },
                          child: playerTile(
                              sleepMusic[i].title!,
                              sleepMusic[i].duration!,
                              0,
                              Provider.of<SleepProvider>(context, listen: false)
                                      .imagePath +
                                  sleepMusic[i].imageFile!),
                        )
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
