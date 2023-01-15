import 'package:flutter/material.dart';

import '../../widgets/answersOptions.dart';
import '../../widgets/questionWidgets.dart';

class AgeQuestionScreen extends StatefulWidget {
  const AgeQuestionScreen({super.key});

  @override
  State<AgeQuestionScreen> createState() => _AgeQuestionScreenState();
}

class _AgeQuestionScreenState extends State<AgeQuestionScreen> {
  List<String> options = [
    'Less than 20',
    '20s',
    '30s',
    '40s',
    '50s',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          header('Thanks, how old are you?',
              'We will try to show the content that you will like'),
          const SizedBox(height: 100),
          AnswerOptionsWidget(options: options)
        ],
      ),
    );
  }
}
