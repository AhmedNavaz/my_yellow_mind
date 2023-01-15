import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/drawer/providers/chatbotProvider.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../../constants/style.dart';
import '../../authentication/provider/authProvider.dart';

class AIFriendScreen extends StatefulWidget {
  const AIFriendScreen({super.key});

  @override
  State<AIFriendScreen> createState() => _AIFriendScreenState();
}

class _AIFriendScreenState extends State<AIFriendScreen> {
  TextEditingController chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Friend',
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
              const SizedBox(height: 75),
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://miro.medium.com/max/640/0*2wFBAnT5SM6sam5a.jpg'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  for (int i = 0;
                      i <
                          Provider.of<ChatbotProvider>(context, listen: true)
                              .currentQuestion
                              .length;
                      i++)
                    Center(
                      child: Text(
                        Provider.of<ChatbotProvider>(context, listen: true)
                            .currentQuestion[i]['dialogue']!,
                        style: customTextStyle(14, FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 50),
              Provider.of<ChatbotProvider>(context, listen: true)
                      .currentOptions
                      .isNotEmpty
                  ? Wrap(
                      children: [
                        for (var i = 0;
                            i <
                                Provider.of<ChatbotProvider>(context,
                                        listen: true)
                                    .currentOptions
                                    .length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.only(right: 20, top: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                UIBlock.block(context);
                                String token = Provider.of<AuthProvider>(
                                        context,
                                        listen: false)
                                    .localUser
                                    .token!;
                                Provider.of<ChatbotProvider>(context,
                                        listen: false)
                                    .askChatbot(
                                        Provider.of<ChatbotProvider>(context,
                                                listen: false)
                                            .currentQuestion[0]['dialogue']!,
                                        chatController.text,
                                        token)
                                    .then((value) {
                                  UIBlock.unblock(context);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                Provider.of<ChatbotProvider>(context,
                                        listen: true)
                                    .currentOptions[i],
                                style: customTextStyle(13, FontWeight.w500),
                              ),
                            ),
                          ),
                      ],
                    )
                  : TextFormField(
                      controller: chatController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            UIBlock.block(context);
                            String token = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .localUser
                                .token!;
                            Provider.of<ChatbotProvider>(context, listen: false)
                                .askChatbot(
                                    Provider.of<ChatbotProvider>(context,
                                            listen: false)
                                        .currentQuestion[0]['dialogue']!,
                                    chatController.text,
                                    token)
                                .then((value) {
                              chatController.clear();
                              UIBlock.unblock(context);
                            });
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ),
                    ),
              // const SizedBox(height: 150),
              // Center(child: Image.asset('assets/icons/mic.png')),
              // const SizedBox(height: 20),
              // Center(
              //   child: Text(
              //     'Tap on mic to talk',
              //     style: customTextStyle(14, FontWeight.w300),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
