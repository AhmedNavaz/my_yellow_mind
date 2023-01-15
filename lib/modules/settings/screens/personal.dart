import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../authentication/provider/authProvider.dart';
import '../models/profileModel.dart';
import '../provider/profileProvider.dart';
import '../widgets/settingsWidgets.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  Future<ProfileModel> getScreenData() async {
    String token =
        Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    return await Provider.of<ProfileProvider>(context, listen: false)
        .getData(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Personal',
          style: customTextStyle(16, FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
          future: getScreenData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Consumer<ProfileProvider>(
                builder: (context, profileData, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        editDialog(context, profileData, 'Name').then((value) {
                          if (value != null) {
                            UIBlock.block(context);
                            String token = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .localUser
                                .token!;
                            Provider.of<ProfileProvider>(context, listen: false)
                                .changeName(value, token)
                                .then((value) {
                              UIBlock.unblock(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Name changed successfully'),
                                ),
                              );
                            });
                          }
                        });
                      },
                      child: personalTile('Name', profileData.userDto.name!,
                          'assets/icons/name.svg'),
                    ),
                    InkWell(
                      onTap: () {
                        editDialog(context, profileData, 'Height')
                            .then((value) {
                          if (value != null) {
                            UIBlock.block(context);
                            String token = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .localUser
                                .token!;
                            Provider.of<ProfileProvider>(context, listen: false)
                                .changeHeight(int.parse(value), token)
                                .then((value) {
                              UIBlock.unblock(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Height changed successfully'),
                                ),
                              );
                            });
                          }
                        });
                      },
                      child: personalTile(
                          'Height',
                          '${profileData.userDto.height!}ft',
                          'assets/icons/height.svg'),
                    ),
                    InkWell(
                      onTap: () {
                        editDialog(context, profileData, 'Weight')
                            .then((value) {
                          if (value != null) {
                            UIBlock.block(context);
                            String token = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .localUser
                                .token!;
                            Provider.of<ProfileProvider>(context, listen: false)
                                .changeWeight(int.parse(value), token)
                                .then((value) {
                              UIBlock.unblock(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Weight changed successfully'),
                                ),
                              );
                            });
                          }
                        });
                      },
                      child: personalTile(
                          'Weight',
                          '${profileData.userDto.weight!}kg',
                          'assets/icons/weight.svg'),
                    ),
                    InkWell(
                      onTap: () {
                        editDialog(context, profileData, 'Age').then((value) {
                          if (value != null) {
                            UIBlock.block(context);
                            String token = Provider.of<AuthProvider>(context,
                                    listen: false)
                                .localUser
                                .token!;
                            Provider.of<ProfileProvider>(context, listen: false)
                                .changeAge(int.parse(value), token)
                                .then((value) {
                              UIBlock.unblock(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Age changed successfully'),
                                ),
                              );
                            });
                          }
                        });
                      },
                      child: personalTile(
                          'Age',
                          profileData.userDto.age!.toString(),
                          'assets/icons/personal.svg'),
                    ),
                    personalTile('Contact Info', 'Manage your contact info',
                        'assets/icons/contact.svg'),
                  ],
                ),
              );
            });
          }),
    );
  }

  Future<dynamic> editDialog(
      BuildContext context, ProfileProvider profileData, String title) {
    var data = null;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change $title'),
            content: TextField(
              onChanged: (value) {
                data = value;
              },
              keyboardType:
                  title == 'Name' ? TextInputType.text : TextInputType.number,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, data);
                  },
                  child: const Text('Save')),
            ],
          );
        });
  }
}
