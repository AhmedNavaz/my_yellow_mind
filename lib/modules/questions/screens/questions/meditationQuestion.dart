import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/questions/widgets/answersOptions.dart';
import 'package:my_yellow_mind/modules/questions/widgets/questionWidgets.dart';
import 'package:my_yellow_mind/modules/settings/provider/profileProvider.dart';
import 'package:provider/provider.dart';

class MeditationQuestionScreen extends StatefulWidget {
  const MeditationQuestionScreen({super.key});

  @override
  State<MeditationQuestionScreen> createState() =>
      _MeditationQuestionScreenState();
}

class _MeditationQuestionScreenState extends State<MeditationQuestionScreen> {
  String? username;
  List<String> options = ['None', 'Some', 'Alot'];
  @override
  void initState() {
    username =
        Provider.of<ProfileProvider>(context, listen: false).userDto.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          header(
              'Hi $username, how much experience do you have with meditation?',
              'Let us know about your experience'),
          const SizedBox(height: 100),
          AnswerOptionsWidget(options: options)
        ],
      ),
    );
  }
}
