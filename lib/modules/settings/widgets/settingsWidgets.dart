import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/style.dart';

InkWell settingTile(
    BuildContext context, String title, String icon, String route) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: ListTile(
          leading: SvgPicture.asset(icon),
          title: Text(
            title,
            style: customTextStyle(15, FontWeight.w500),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 17.5,
            color: Color(0xffAFAFAF),
          ),
        ),
      ),
    ),
  );
}

Column personalTile(String title, String subtitle, String leadingIcon) {
  return Column(
    children: [
      ListTile(
        leading: SvgPicture.asset(leadingIcon),
        title: Text(
          title,
          style: customTextStyle(15, FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: customTextStyle(15, FontWeight.w500,
              color: Colors.black.withOpacity(0.54)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 20,
        ),
      ),
      const SizedBox(height: 10),
      Divider(
        height: 0,
        thickness: 5,
        color: Colors.grey.shade200,
      ),
      const SizedBox(height: 15),
    ],
  );
}

Column profileTile(String title, IconData leadingIcon) {
  return Column(
    children: [
      ListTile(
        leading: Icon(leadingIcon, color: Colors.black),
        title: Text(
          title,
          style: customTextStyle(15, FontWeight.w500),
        ),
      ),
      const SizedBox(height: 10),
      Divider(
        height: 0,
        thickness: 5,
        color: Colors.grey.shade200,
      ),
      const SizedBox(height: 15),
    ],
  );
}
