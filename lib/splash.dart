import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/routeNames.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 2), () async {
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, WrapperRoute, (route) => false);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/splash.png"), fit: BoxFit.cover),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        // body: Stack(
        //   children: [
        //     // black overlay
        //     Container(
        //       color: Colors.black.withOpacity(0.3),
        //     ),
        //     Center(
        //       child: Image.asset('assets/images/signature-large.png'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
