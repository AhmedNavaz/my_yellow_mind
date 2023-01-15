import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/style.dart';

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget(
      {Key? key,
      required this.textController,
      required this.title,
      required this.hintText,
      required this.validator,
      required this.obscure})
      : super(key: key);

  final TextEditingController textController;
  final String title;
  final String hintText;
  final bool obscure;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            title,
            style: customTextStyle(14, FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: textController,
            style: customTextStyle(13, FontWeight.w500),
            cursorColor: primaryColor,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  customTextStyle(13, FontWeight.w500, color: Colors.grey),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              errorStyle: const TextStyle(color: Colors.grey, height: 0.1),
              contentPadding: const EdgeInsets.only(
                  right: 20, top: 10, bottom: 10, left: 20),
            ),
            textInputAction: TextInputAction.next,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
