import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/authentication/provider/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../../settings/provider/profileProvider.dart';
import '../../widgets/questionWidgets.dart';

class NameQuestionScreen extends StatefulWidget {
  const NameQuestionScreen({super.key});

  @override
  State<NameQuestionScreen> createState() => _NameQuestionScreenState();
}

class _NameQuestionScreenState extends State<NameQuestionScreen> {
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text =
        Provider.of<AuthProvider>(context, listen: false).localUser.name!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          header('Welcome to App',
              'We would like to know more about you, let\'s start with some basics. What\'s your name?'),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _nameController,
              cursorColor: Color(0xff970000),
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff970000))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff970000))),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: const Color(0xff7E0000),
              child: IconButton(
                onPressed: () {
                  String token =
                      Provider.of<AuthProvider>(context, listen: false)
                          .localUser
                          .token!;
                  UIBlock.block(context);
                  Provider.of<ProfileProvider>(context, listen: false)
                      .changeName(_nameController.text, token)
                      .then((value) {
                    if (value) {
                      UIBlock.unblock(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Name Added Successfully'),
                        ),
                      );
                    } else {
                      UIBlock.unblock(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Something went wrong'),
                      ));
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
