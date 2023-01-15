import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/modules/cbt/providers/database.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../constants/style.dart';
import '../providers/cbtProvider.dart';

class LiveSessionScreen extends StatefulWidget {
  LiveSessionScreen({super.key, required this.liveSession});

  Map<String, dynamic> liveSession;

  @override
  State<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends State<LiveSessionScreen> {
  final audioPlayer = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late var audioUrl;
  bool isPlaying = false;
  bool isPaused = false;
  final List<double> values = [];

  TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  @override
  void initState() {
    audioUrl = UrlSource(
        Provider.of<CBTProvider>(context, listen: false).videoPath +
            widget.liveSession['vidAudFile']);
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
      if (duration.inSeconds == position.inSeconds) {
        play();
      }
        // Navigator.pushNamed(context, SessionReviewRoute);
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    play();
    // scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> play() async {
    await audioPlayer.play(audioUrl);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }

  DatabaseMethods databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                Provider.of<CBTProvider>(context, listen: false).imagePath +
                    widget.liveSession['fileName']),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffB10000)),
              child: Text(
                'Live',
                style:
                    customTextStyle(11, FontWeight.w500, color: Colors.white),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 80,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Slider(
                        activeColor: const Color(0xff00B6BC),
                        inactiveColor: Colors.grey.shade300,
                        thumbColor: Colors.white,
                        min: 0.0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            changeToSecond(value.toInt());
                            value = value;
                          });
                          if (value == duration.inSeconds.toDouble()) {
                            setState(() {
                              isPlaying = false;
                              audioPlayer.stop();
                            });
                            Navigator.pushNamed(context, SessionReviewRoute);
                          }
                        }),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          position.toString().split(".")[0],
                          style: customTextStyle(13, FontWeight.w300,
                              color: Colors.white),
                        ),
                        Text(
                          duration.toString().split(".")[0],
                          style: customTextStyle(13, FontWeight.w300,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  '${widget.liveSession['participants']} People are watching',
                                  style: customTextStyle(14, FontWeight.w500,
                                      color: Colors.white)),
                            ),
                            const SizedBox(height: 30),
                            Expanded(
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('cbt_sessions')
                                      .doc(widget.liveSession['sessionId']
                                          .toString())
                                      .collection('cbt_chat')
                                      .orderBy('createdAt', descending: false)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    }
                                    return snapshot.data!.docs.isEmpty
                                        ? const Center(
                                            child: Text('No chat yet'))
                                        : ListView.builder(
                                            controller: scrollController,
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: ListTile(
                                                    leading: const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      radius: 25,
                                                      backgroundImage:
                                                          NetworkImage(''),
                                                    ),
                                                    title: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 100),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child: BackdropFilter(
                                                          filter:
                                                              ImageFilter.blur(
                                                                  sigmaX: 20,
                                                                  sigmaY: 20),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        15,
                                                                    horizontal:
                                                                        15),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .shade400
                                                                    .withOpacity(
                                                                        0.25),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['text'],
                                                              style: customTextStyle(
                                                                  14,
                                                                  FontWeight
                                                                      .w500,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                              );
                                            },
                                          );
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Form(
                                key: _formKey,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 20, sigmaY: 20),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.25),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: TextFormField(
                                              controller: textEditingController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Type a message...',
                                                  hintStyle: customTextStyle(
                                                      14, FontWeight.w500)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        if (textEditingController
                                            .text.isNotEmpty) {
                                          // Provider.of<CBTProvider>(context,
                                          //         listen: false)
                                          //     .addTextToMessages(
                                          //         textEditingController.text);
                                          String tempId = const Uuid().v1();

                                          databaseMethods.addReply(
                                              widget.liveSession['sessionId']
                                                  .toString(),
                                              tempId,
                                              textEditingController.text,
                                              DateTime.now());
                                          textEditingController.clear();

                                          setState(() {});
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            scrollController.animateTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeOut,
                                            );
                                          });
                                        }
                                      },
                                      child: const CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.send,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
