import 'package:flutter/material.dart';
import 'package:my_yellow_mind/constants/style.dart';
import 'package:my_yellow_mind/modules/settings/provider/subscriptionProvider.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import 'constants/routeNames.dart';
import 'modules/authentication/provider/authProvider.dart';

class LockedFeatures extends StatefulWidget {
  const LockedFeatures({Key? key}) : super(key: key);

  @override
  State<LockedFeatures> createState() => _LockedFeaturesState();
}

class _LockedFeaturesState extends State<LockedFeatures> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Provider.of<SubscriptionProvider>(context, listen: true).freeTrial ? 'Free trial expired' :'Start your 3-day free trial.',
                style: customTextStyle(18, FontWeight.w600)),
            const SizedBox(height: 5),
            Text('This feature is locked.',
                style:
                    customTextStyle(14, FontWeight.w500, color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if(Provider.of<SubscriptionProvider>(context, listen: true).freeTrial){
                  Navigator.pushNamed(context, SubscriptionScreenRoute);
                }
                else{
                  UIBlock.block(context);
                  String token =
                  Provider.of<AuthProvider>(context, listen: false).localUser.token!;
                  Provider.of<SubscriptionProvider>(context, listen: false).activateFreeTrial(token, true, DateTime.now()).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            '3 day trial activated'),
                      ),
                    );
                    UIBlock.unblock(context);
                  });
                }

              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: Text(
                'Unlock Now',
                style:
                    customTextStyle(16, FontWeight.w700, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
