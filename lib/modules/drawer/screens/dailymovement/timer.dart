import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../constants/style.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen({super.key, required this.minutes});

  final int minutes;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late String hours;
  late String minutes;
  late String seconds;

  late Timer _timer;

  bool isPaused = true;
  @override
  void initState() {
    // get the hours, minutes and seconds from the minutes
    hours = (widget.minutes / 60).floor().toString().padLeft(2, '0');
    minutes = (widget.minutes % 60).floor().toString().padLeft(2, '0');
    seconds = '00';
    super.initState();
  }

  // start the timer
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (int.parse(seconds) > 0) {
        setState(() {
          seconds = (int.parse(seconds) - 1).toString();
        });
      } else {
        if (int.parse(minutes) > 0) {
          setState(() {
            minutes = (int.parse(minutes) - 1).toString();
            seconds = '59';
          });
        } else {
          if (int.parse(hours) > 0) {
            setState(() {
              hours = (int.parse(hours) - 1).toString();
              minutes = '59';
              seconds = '59';
            });
          } else {
            timer.cancel();
          }
        }
      }
    });
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
          'Workout',
          style: customTextStyle(16, FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          hours,
                          style: customTextStyle(45, FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hours',
                          style: customTextStyle(17, FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          minutes,
                          style: customTextStyle(45, FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Minutes',
                          style: customTextStyle(17, FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          seconds,
                          style: customTextStyle(45, FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Seconds',
                          style: customTextStyle(17, FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Let\s go!',
              style: customTextStyle(16, FontWeight.w500),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.arrow_back_ios, color: Colors.black),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPaused = !isPaused;
                    });
                    if (!isPaused) {
                      startTimer();
                    } else {
                      _timer.cancel();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      backgroundColor: const Color(0xffE6E6E6)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      isPaused ? 'Start' : 'Stop',
                      style: customTextStyle(17, FontWeight.w500),
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.black),
              ],
            ),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () {
                  setState(() {
                    isPaused = true;
                    hours = (widget.minutes / 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    minutes = (widget.minutes % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    seconds = '00';
                  });
                },
                child: Text(
                  'Reset',
                  style: customTextStyle(14, FontWeight.w500),
                ))
          ],
        ),
      ),
    );
  }
}
