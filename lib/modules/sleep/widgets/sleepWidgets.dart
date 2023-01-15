import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_yellow_mind/modules/sleep/models/sleepCategories.dart';
import 'package:my_yellow_mind/modules/sleep/models/sleepModel.dart';
import 'package:my_yellow_mind/modules/sleep/providers/sleepProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/routeNames.dart';
import '../../../constants/style.dart';

Card playerTile(String title, int duration, int listener, String image) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
            ),
            child: SvgPicture.asset(
              'assets/icons/play-video-button.svg',
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: customTextStyle(14, FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text(
                  '$duration minutes',
                  style: customTextStyle(11, FontWeight.w500,
                      color: primaryColor.withOpacity(0.65)),
                ),
              ],
            ),
          ),
          Text(
            '$listener Listeners',
            style: customTextStyle(10, FontWeight.w300,
                color: primaryColor.withOpacity(0.72)),
          ),
        ],
      ),
    ),
  );
}

InkWell sleepCategoryBox(BuildContext context, SleepCategories sleepMusic) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, SleepCategoriesRoute,
          arguments: sleepMusic.toJson());
    },
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30),
          height: 175,
          width: 177,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  Provider.of<SleepProvider>(context, listen: false).imagePath +
                      sleepMusic.imageName!),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Text(
          sleepMusic.name!,
          style: customTextStyle(15, FontWeight.w500),
        ),
      ],
    ),
  );
}
