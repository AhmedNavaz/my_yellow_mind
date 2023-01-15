import 'package:flutter/material.dart';

import '../../../constants/style.dart';

Column header(String title, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: customTextStyle(18, FontWeight.w600)),
      const SizedBox(height: 20),
      Text(description, style: customTextStyle(15, FontWeight.w500)),
    ],
  );
}
