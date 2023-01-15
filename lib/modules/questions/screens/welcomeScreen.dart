import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/questions/providers/questionProvider.dart';
import 'package:my_yellow_mind/modules/questions/screens/questions/ageQuestion.dart';
import 'package:my_yellow_mind/modules/questions/screens/questions/disclaimer.dart';
import 'package:my_yellow_mind/modules/questions/screens/questions/interestsQuestion.dart';
import 'package:my_yellow_mind/modules/questions/screens/questions/meditationQuestion.dart';
import 'package:my_yellow_mind/modules/questions/screens/questions/moodQuestion.dart';
import 'package:my_yellow_mind/modules/questions/screens/questions/nameQuestion.dart';
import 'package:my_yellow_mind/modules/questions/screens/questions/packages.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../authentication/provider/authProvider.dart';
import '../../drawer/providers/moodCheckProvider.dart';
import '../../meditation/provider/meditationProvider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  PageController _pageController = PageController();
  FocusNode _focusNode = FocusNode();

  late final List<Widget> _pages = [
    const NameQuestionScreen(),
    const MeditationQuestionScreen(),
    const AgeQuestionScreen(),
    const InterestsQuestionScreen(),
    const MoodQuestionScreen(),
    const DisclaimerScreen(),
    const PackagesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  Provider.of<QuestionProvider>(context, listen: false)
                      .changeCurrentQuestion(value);
                });
              },
              children: _pages,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String token = Provider.of<AuthProvider>(context, listen: false)
                  .localUser
                  .token!;
              // 1. Name
              if (Provider.of<QuestionProvider>(context, listen: false)
                      .currentQuestion ==
                  0) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
              // 2. Meditation
              if (Provider.of<QuestionProvider>(context, listen: false)
                      .currentQuestion ==
                  1) {
                UIBlock.block(context);
                Provider.of<QuestionProvider>(context, listen: false)
                    .saveAnswer(
                        3,
                        Provider.of<QuestionProvider>(context, listen: false)
                            .answer!,
                        token)
                    .then((value) {
                  if (value) {
                    UIBlock.unblock(context);
                  } else {
                    UIBlock.unblock(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  }
                });
              }
              // 3. Age
              if (Provider.of<QuestionProvider>(context, listen: false)
                      .currentQuestion ==
                  2) {
                UIBlock.block(context);
                Provider.of<QuestionProvider>(context, listen: false)
                    .saveAnswer(
                        4,
                        Provider.of<QuestionProvider>(context, listen: false)
                            .answer!,
                        token)
                    .then((value) {
                  if (value) {
                    UIBlock.unblock(context);
                  } else {
                    UIBlock.unblock(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  }
                });
              }

              // 4. Interest
              if (Provider.of<QuestionProvider>(context, listen: false)
                      .currentQuestion ==
                  3) {
                if (Provider.of<QuestionProvider>(context, listen: false)
                        .selectedCategores
                        .isEmpty ||
                    Provider.of<QuestionProvider>(context, listen: false)
                            .selectedCategores
                            .length >
                        3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select between 1-3 categories!'),
                    ),
                  );
                  return;
                }
                UIBlock.block(context);
                String token = Provider.of<AuthProvider>(context, listen: false)
                    .localUser
                    .token!;
                Provider.of<QuestionProvider>(context, listen: false)
                    .addUserCategories(
                        token,
                        Provider.of<QuestionProvider>(context, listen: false)
                            .selectedCategores
                            .toString())
                    .then((value) {
                  UIBlock.unblock(context);
                });
              }

              // 5. Mood
              if (Provider.of<QuestionProvider>(context, listen: false)
                      .currentQuestion ==
                  4) {
                UIBlock.block(context);
                Provider.of<MoodCheckProvider>(context, listen: false)
                    .setMood(
                        Provider.of<QuestionProvider>(context, listen: false)
                            .answer!,
                        token)
                    .then((value) {
                  if (value) {
                    Provider.of<MeditationProvider>(context, listen: false)
                        .setMoodCheck(Provider.of<QuestionProvider>(context,
                                listen: false)
                            .answer!);
                    UIBlock.unblock(context);
                  } else {
                    UIBlock.unblock(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Something went wrong'),
                      ),
                    );
                  }
                });
              }

              if (Provider.of<QuestionProvider>(context, listen: false)
                      .currentQuestion ==
                  _pages.length - 1) {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreenRoute, (route) => false);
              } else {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Continue',
              style: customTextStyle(15, FontWeight.w600),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
