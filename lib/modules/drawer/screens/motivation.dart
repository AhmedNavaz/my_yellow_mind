import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/style.dart';
import '../../authentication/provider/authProvider.dart';
import '../providers/motivationProvider.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({super.key});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  late VideoPlayerController _controller;
  bool isLoading = true;
  bool videoLoading = true;
  @override
  void initState() {
    getScreenData().then((value) {
      _controller = VideoPlayerController.network(value)
        ..initialize().then((_) {
          setState(() {
            videoLoading = false;
          });
        });
    });
    super.initState();
  }

  Future<String> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    await Provider.of<MotivationProvider>(context, listen: false)
        .getData(token);
    setState(() {
      isLoading = false;
    });
    String url =
        Provider.of<MotivationProvider>(context, listen: false).videoPath +
            Provider.of<MotivationProvider>(context, listen: false)
                .vidAudFilesDtoList[0]
                .vidAudFile;
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Motivation',
          style: customTextStyle(17, FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            _controller.pause();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('We have picked a video for you',
                          style: customTextStyle(16, FontWeight.w500)),
                    ),
                    const SizedBox(height: 40),
                    _controller.value.isPlaying
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  VideoPlayer(_controller),
                                  _ControlsOverlay(controller: _controller),
                                  VideoProgressIndicator(_controller,
                                      allowScrubbing: true),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.8),
                                    BlendMode.dstATop),
                                image: NetworkImage(
                                    Provider.of<MotivationProvider>(context,
                                                listen: false)
                                            .imagePath +
                                        Provider.of<MotivationProvider>(context,
                                                listen: false)
                                            .vidAudFilesDtoList[0]
                                            .imageFile!),
                                fit: BoxFit.cover,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.75),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: videoLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Center(
                                      child: SvgPicture.asset(
                                          'assets/icons/play-button.svg')),
                            ),
                          ),
                    const SizedBox(height: 30),
                    Text(
                        Provider.of<MotivationProvider>(context, listen: false)
                            .vidAudFilesDtoList[0]
                            .title!,
                        textAlign: TextAlign.center,
                        style: customTextStyle(16, FontWeight.w500)),
                    const SizedBox(height: 10),
                    Text(
                        Provider.of<MotivationProvider>(context, listen: false)
                            .vidAudFilesDtoList[0]
                            .subCategory!,
                        style: customTextStyle(15, FontWeight.w500,
                            color: Colors.black.withOpacity(0.69))),
                    const SizedBox(height: 50),
                    _controller.value.isPlaying || videoLoading
                        ? const SizedBox.shrink()
                        : ElevatedButton(
                            onPressed: () {
                              _controller.play();
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                'Watch Video',
                                style: customTextStyle(15, FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
            setState(() {});
          },
        ),
      ],
    );
  }
}
