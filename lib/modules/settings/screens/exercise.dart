import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../questions/widgets/questionWidgets.dart';

class ExerciseSettingsScreen extends StatefulWidget {
  const ExerciseSettingsScreen({super.key});

  @override
  State<ExerciseSettingsScreen> createState() => _ExerciseSettingsScreenState();
}

class _ExerciseSettingsScreenState extends State<ExerciseSettingsScreen> {
  List<String> suggestions = [
    'Walking',
    'Breating',
    'Running',
    'Gymnastics',
    'Weight Lifting',
    'Yoga',
    'Squats',
    'Sports',
    'Push-Ups',
    'Group Exercise',
    'Flexibility',
    'Skating',
    'Jogging',
    'Stretching',
    'Balance Exercise'
  ];

  List<bool>? selectedInterests;
  @override
  void initState() {
    selectedInterests = List.filled(suggestions.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Exercise',
          style: customTextStyle(16, FontWeight.w500),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header('Change your exercise category', ''),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 5,
                      children: [
                        for (var index = 0; index < suggestions.length; index++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedInterests![index] =
                                    !selectedInterests![index];
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Card(
                                color: selectedInterests![index]
                                    ? const Color(0xff970000)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Text(suggestions[index],
                                      style: customTextStyle(
                                          14, FontWeight.w500,
                                          color: selectedInterests![index]
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Save',
                          style: customTextStyle(15, FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
