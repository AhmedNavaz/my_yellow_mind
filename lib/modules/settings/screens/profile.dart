import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/settings/widgets/settingsWidgets.dart';

import '../../../constants/style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Profile',
          style: customTextStyle(16, FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://picsum.photos/200'),
          ),
          const SizedBox(height: 40),
          profileTile('Edit Profile', Icons.edit),
          profileTile('Account Info', Icons.person),
          profileTile('Manage Subscription', Icons.payment),
          profileTile('Change Password', Icons.key),
          profileTile('Change Language', Icons.language),
          profileTile('Logout', Icons.logout),
        ],
      ),
    );
  }
}
