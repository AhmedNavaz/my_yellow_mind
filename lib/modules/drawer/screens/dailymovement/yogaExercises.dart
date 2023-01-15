import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/modules/drawer/widgets/dailyMovementWidgets.dart';

import '../../../../constants/style.dart';

class YogaExercisesScreen extends StatefulWidget {
  YogaExercisesScreen({super.key, required this.data});

  Map<String, dynamic> data;

  @override
  State<YogaExercisesScreen> createState() => _YogaExercisesScreenState();
}

class _YogaExercisesScreenState extends State<YogaExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: GridView.builder(
            itemCount: widget.data['exercises'].length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.25,
            ),
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MediaPlayerRoute,
                      arguments: widget.data['exercises'][index]);
                },
                child: yogaExerciseBox(
                  context,
                  widget.data['exercises'][index]['title'],
                  widget.data['exercises'][index]['image'],
                ),
              );
            })),
      ),
    );
  }
}
