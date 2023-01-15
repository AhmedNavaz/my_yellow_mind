import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/authentication/provider/authProvider.dart';
import 'package:my_yellow_mind/modules/meditation/provider/meditationProvider.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:wave_progress_bars/wave_progress_bars.dart';
import 'package:audioplayers/audioplayers.dart';

class MeditationPlayerScreen extends StatefulWidget {
  MeditationPlayerScreen({super.key, required this.data});

  Map<String, dynamic> data;

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late Source audioUrl;
  bool isPlaying = false;
  bool isPaused = false;
  bool loadingFile = false;
  final List<double> values = [];

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  double getPercentage() {
    if (position.inSeconds == 0) {
      return 0;
    } else {
      return position.inSeconds / duration.inSeconds * 100;
    }
  }

  @override
  void initState() {
    audioUrl = UrlSource(
        Provider.of<MeditationProvider>(context, listen: false).videoPath +
            widget.data['vidAudFile']);
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });

    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    var rng = new Random();
    for (var i = 0; i < 80; i++) {
      values.add(rng.nextInt(70) * 1.0);
    }
    play();
  }

  Future<void> play() async {
    setState(() {
      loadingFile = true;
    });
    await audioPlayer.play(audioUrl);
    setState(() {
      loadingFile = false;
      isPlaying = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  height: 200,
                  width: size.width * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    image: DecorationImage(
                        image: NetworkImage(Provider.of<MeditationProvider>(
                                    context,
                                    listen: false)
                                .imagePath +
                            widget.data['imageFile']),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 15),
                Text(widget.data['title'],
                    style: customTextStyle(14, FontWeight.w500)),
                const SizedBox(height: 2.5),
                Text('${widget.data['duration']} minutes',
                    style: customTextStyle(12, FontWeight.w500,
                        color: Colors.black.withOpacity(0.65))),
                const SizedBox(height: 40),
                WaveProgressBar(
                  progressPercentage: getPercentage(),
                  listOfHeights: values,
                  width: size.width * 0.6,
                  initalColor: Colors.grey,
                  progressColor: const Color(0xff006FFF),
                  backgroundColor: Colors.white,
                  timeInMilliSeconds: 1000,
                  isHorizontallyAnimated: true,
                  isVerticallyAnimated: true,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 66),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        position.toString().split(".")[0],
                        style: customTextStyle(11, FontWeight.w500,
                            color: Colors.black.withOpacity(0.65)),
                      ),
                      Text(
                        duration.toString().split(".")[0],
                        style: customTextStyle(11, FontWeight.w500,
                            color: Colors.black.withOpacity(0.65)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          changeToSecond(position.inSeconds - 10);
                        },
                        icon: const Icon(Icons.skip_previous, size: 50)),
                    const SizedBox(width: 30),
                    loadingFile
                        ? const CircularProgressIndicator(
                            color: Colors.black, strokeWidth: 3)
                        : IconButton(
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              if (!isPlaying && !isPaused) {
                                play();
                              } else if (isPlaying) {
                                audioPlayer.pause();
                                setState(() {
                                  isPlaying = false;
                                  isPaused = true;
                                });
                              } else if (!isPlaying && isPaused) {
                                audioPlayer.resume();
                                setState(() {
                                  isPlaying = true;
                                  isPaused = false;
                                });
                              }
                            },
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 50)),
                    const SizedBox(width: 30),
                    IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          changeToSecond(position.inSeconds + 10);
                        },
                        icon: const Icon(Icons.skip_next, size: 50)),
                  ],
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Overview',
                      style: customTextStyle(15, FontWeight.w500,
                          color: Colors.black)),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.data['description'],
                  style:
                      customTextStyle(13, FontWeight.w500, color: Colors.grey),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
