import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';
import 'package:my_yellow_mind/modules/authentication/provider/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../../constants/style.dart';
import '../providers/moodCheckProvider.dart';

class MoodCheckScreen extends StatefulWidget {
  const MoodCheckScreen({super.key});

  @override
  State<MoodCheckScreen> createState() => _MoodCheckScreenState();
}

class _MoodCheckScreenState extends State<MoodCheckScreen> {
  List<String> options = [
    'Sad 😕',
    'Happy 🙂',
    'Very Happy 🤩',
  ];
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mood Check',
          style: customTextStyle(17, FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://www.snacknation.com/wp-content/uploads/2015/07/Motivation-videos-for-employees.jpg'),
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
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Tell us about your mood',
                    style: customTextStyle(16, FontWeight.w500)),
              ),
              const SizedBox(height: 75),
              // radio tile
              for (int i = 0; i < options.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: RadioListTile(
                    value: i,
                    groupValue: selected,
                    onChanged: (value) {
                      setState(() {
                        selected = value!;
                      });
                    },
                    activeColor: Colors.black,
                    title: Card(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text(
                          options[i],
                          style: customTextStyle(15, FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (selected != -1) {
                    UIBlock.block(context);
                    var temp = options[selected].split(' ');
                    temp = temp.sublist(0, temp.length - 1);
                    String res = temp.join(' ');
                    Provider.of<MoodCheckProvider>(context, listen: false)
                        .setMood(
                            res,
                            Provider.of<AuthProvider>(context, listen: false)
                                .localUser
                                .token!)
                        .then((value) {
                      if (value) {
                        UIBlock.unblock(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreenRoute, (route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Mood set successfully'),
                          ),
                        );
                      } else {
                        UIBlock.unblock(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Something went wrong'),
                          ),
                        );
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    'Submit',
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
