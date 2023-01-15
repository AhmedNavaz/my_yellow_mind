import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../providers/questionProvider.dart';

class AnswerOptionsWidget extends StatefulWidget {
  AnswerOptionsWidget({super.key, this.options});

  List<String>? options;

  @override
  State<AnswerOptionsWidget> createState() => _AnswerOptionsWidgetState();
}

class _AnswerOptionsWidgetState extends State<AnswerOptionsWidget> {
  int selectedOption = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.options!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = index;
            });
            Provider.of<QuestionProvider>(context, listen: false)
                .setAnswer(widget.options![index]);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            child: Card(
              color: selectedOption == index
                  ? const Color(0xff970000)
                  : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Container(
                width: 250,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  widget.options![index],
                  style: customTextStyle(15, FontWeight.w500,
                      color: selectedOption == index
                          ? Colors.white
                          : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
