import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/style.dart';

Container yogaPlanTile(
    BuildContext context, String title, String image, int duration) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    height: 160,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.75),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 5), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: customTextStyle(16, FontWeight.w500, color: Colors.white),
          ),
          Center(
              child: SvgPicture.asset(
            'assets/icons/play-video-button.svg',
            height: 50,
            width: 50,
          )),
          Text(
            '$duration min',
            style: customTextStyle(11, FontWeight.w500, color: Colors.white),
          )
        ],
      ),
    ),
  );
}

Container yogaExerciseBox(BuildContext context, String name, String image) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.75),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 5), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
              child: SvgPicture.asset(
            'assets/icons/play-video-button.svg',
          )),
          const SizedBox(height: 20),
          Text(
            name,
            style: customTextStyle(13, FontWeight.w600, color: Colors.white),
          )
        ],
      ),
    ),
  );
}

Container meditationPlanTile(
    BuildContext context, String title, String image, int duration) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    height: 160,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.75),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 5), // changes position of shadow
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$duration min',
              style: customTextStyle(10, FontWeight.w500, color: Colors.white),
            ),
          ),
          Center(
              child: SvgPicture.asset(
            'assets/icons/play-video-button.svg',
            height: 50,
            width: 50,
          )),
          Text(
            title,
            style: customTextStyle(13, FontWeight.w600, color: Colors.white),
          )
        ],
      ),
    ),
  );
}
