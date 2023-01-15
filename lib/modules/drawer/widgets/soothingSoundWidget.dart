import 'package:flutter/material.dart';
import '../../../constants/style.dart';

Card soundTile(String title, int duration, String image) {
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
            height: 75,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover),
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
                  '$duration min',
                  style: customTextStyle(11, FontWeight.w500,
                      color: primaryColor.withOpacity(0.65)),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 40,
            ),
          )
        ],
      ),
    ),
  );
}
