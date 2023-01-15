import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';

import '../../../constants/style.dart';
import '../../questions/widgets/answersOptions.dart';
import '../../questions/widgets/questionWidgets.dart';

class SessionReviewScreen extends StatefulWidget {
  const SessionReviewScreen({super.key});

  @override
  State<SessionReviewScreen> createState() => _SessionReviewScreenState();
}

class _SessionReviewScreenState extends State<SessionReviewScreen> {
  List<String> options = [
    'Bad',
    'Normal',
    'Excellent',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        header('How was the session?', ''),
        const SizedBox(height: 75),
        AnswerOptionsWidget(options: options),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreenRoute, (Route<dynamic> route) => false);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Submit',
            style: customTextStyle(15, FontWeight.w600),
          ),
        ),
        const SizedBox(height: 50),
      ],
    ));
  }
}
