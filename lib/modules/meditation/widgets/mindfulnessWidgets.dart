import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/modules/meditation/models/mindCategoriesModel.dart';
import 'package:my_yellow_mind/modules/meditation/provider/meditationProvider.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';

Column statBlock(String image, String title, String value) {
  return Column(
    children: [
      Row(
        children: [
          Image.asset(image),
          Text(
            title,
            style: customTextStyle(11, FontWeight.w500),
          )
        ],
      ),
      const SizedBox(height: 10),
      Text(
        value,
        style: customTextStyle(9, FontWeight.w400),
      )
    ],
  );
}

Container videoCard(String image, String title, int duration) {
  return Container(
    margin: const EdgeInsets.only(right: 20),
    height: 180,
    width: 115,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
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
        ]),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: customTextStyle(13, FontWeight.w600, color: Colors.white),
          ),
          Center(child: SvgPicture.asset('assets/icons/play-button.svg')),
          Text(
            '$duration min',
            style: customTextStyle(10, FontWeight.w400,
                color: Colors.white.withOpacity(0.5)),
          )
        ],
      ),
    ),
  );
}

Container relatedCard(BuildContext context, MindCategories category) {
  return Container(
    margin: const EdgeInsets.only(right: 20),
    child: Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RelatedScreenRoute,
                arguments: category.toJson());
          },
          child: Container(
            height: 82,
            width: 85,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      Provider.of<MeditationProvider>(context).imagePath +
                          category.imageName),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.75),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ]),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 100,
          child: Text(
            category.name!,
            style: customTextStyle(11, FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}

Column relatedTile(String title, String image, int duration, int listeners) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.8), BlendMode.dstATop),
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
                ]),
            child: Padding(
              padding: const EdgeInsets.all(45),
              child: SvgPicture.asset('assets/icons/play-button.svg'),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 175,
                child: Text(
                  title,
                  style: customTextStyle(13, FontWeight.w500),
                ),
              ),
              const SizedBox(height: 5),
              Text('$listeners listeners',
                  style: customTextStyle(10, FontWeight.w300)),
            ],
          ),
          const Spacer(),
          Text(
            '$duration min',
            style: customTextStyle(11, FontWeight.w300, color: Colors.black),
          )
        ],
      ),
      const SizedBox(height: 20),
      Divider(
        color: Colors.grey.withOpacity(0.5),
        thickness: 1,
        indent: 125,
        endIndent: 125,
      ),
      const SizedBox(height: 20),
    ],
  );
}
