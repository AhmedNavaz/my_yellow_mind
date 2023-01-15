import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/modules/meditation/provider/meditationProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../../sleep/models/sleepModel.dart';
import '../widgets/mindfulnessWidgets.dart';

class RelatedHomeScreen extends StatefulWidget {
  RelatedHomeScreen({super.key, this.categoryData});

  Map<String, dynamic>? categoryData;

  @override
  State<RelatedHomeScreen> createState() => _RelatedHomeScreenState();
}

class _RelatedHomeScreenState extends State<RelatedHomeScreen> {
  List<SpUserVidAudWatchCountDtos> data = [];

  @override
  void initState() {
    Provider.of<MeditationProvider>(context, listen: false)
        .getCategoryData(widget.categoryData!['name'])
        .then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.75), BlendMode.dstATop),
                    image: NetworkImage(
                        Provider.of<MeditationProvider>(context, listen: false)
                                .imagePath +
                            widget.categoryData!['imageName']),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      'assets/icons/play-video-button.svg',
                    )),
                    const SizedBox(height: 100),
                    Text(
                      widget.categoryData!['name'],
                      style: customTextStyle(16, FontWeight.w700,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggested Music',
                    style: customTextStyle(13, FontWeight.w300),
                  ),
                  const SizedBox(height: 30),
                  data.isEmpty
                      ? Center(
                          child: Text(
                            'Nothing in this category right now!',
                            style: customTextStyle(12, FontWeight.w400,
                                color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MeditationPlayerRoute,
                                    arguments: data[index].toJson());
                              },
                              child: relatedTile(
                                  data[index].title!,
                                  Provider.of<MeditationProvider>(context,
                                              listen: false)
                                          .imagePath +
                                      data[index].imageFile!,
                                  data[index].duration!,
                                  0),
                            );
                          }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
