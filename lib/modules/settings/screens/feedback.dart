import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Feedback',
          style: customTextStyle(16, FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Feedback',
              style: customTextStyle(20, FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Text('How satisfied are you after using this app',
                style: customTextStyle(14, FontWeight.w500,
                    color: Colors.black.withOpacity(0.33))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['1', '2', '3', '4', '5'].map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        rating = int.parse(e);
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: rating >= int.parse(e)
                          ? const Color(0xffDCA6A6)
                          : const Color(0xffDCA6A6).withOpacity(0.25),
                      child: Center(
                        child: Text(
                          e,
                          style: customTextStyle(15, FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Not Satisfied',
                      style: customTextStyle(14, FontWeight.w500,
                          color: Colors.black.withOpacity(0.33))),
                  Text('Very Satisfied',
                      style: customTextStyle(14, FontWeight.w500,
                          color: Colors.black.withOpacity(0.33))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
