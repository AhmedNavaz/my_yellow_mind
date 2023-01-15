import 'package:flutter/material.dart';

import '../../widgets/answersOptions.dart';
import '../../widgets/questionWidgets.dart';

class MoodQuestionScreen extends StatefulWidget {
  const MoodQuestionScreen({super.key});

  @override
  State<MoodQuestionScreen> createState() => _MoodQuestionScreenState();
}

class _MoodQuestionScreenState extends State<MoodQuestionScreen> {
  List<String> options = ['Sad', 'Happy', 'Very Happy'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          header('How is your mood right now?', ''),
          const SizedBox(height: 75),
          AnswerOptionsWidget(options: options)
        ],
      ),
    );
  }
}
