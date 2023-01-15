import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_yellow_mind/bottomNavbar.dart';
import 'package:my_yellow_mind/modules/authentication/screens/createAccount.dart';
import 'package:my_yellow_mind/modules/settings/provider/subscriptionProvider.dart';
import 'package:my_yellow_mind/splash.dart';
import 'package:provider/provider.dart';

import 'modules/authentication/provider/authProvider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var user;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    var box = await Hive.openBox('user');
    user = await box.get('user');
    if (user != null) {
      Provider.of<AuthProvider>(context, listen: false).user = user;
    }
    String token =
    Provider.of<AuthProvider>(context, listen: false).localUser.token!;
    await Provider.of<SubscriptionProvider>(context, listen: false).setFreeTrial(token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return user == null ? CreateAccountScreen() : const HomeScreen();
          } else {
            return const SplashScreen();
          }
        });
  }
}
