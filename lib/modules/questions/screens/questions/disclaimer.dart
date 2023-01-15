import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/style.dart';

class DisclaimerScreen extends StatefulWidget {
  const DisclaimerScreen({super.key});

  @override
  State<DisclaimerScreen> createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Disclaimer',
            style: customTextStyle(18, FontWeight.w700),
          ),
          const SizedBox(height: 100),
          Text(
            'Please don\'t use mediation when driving or doing operational work.',
            style: customTextStyle(16, FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
