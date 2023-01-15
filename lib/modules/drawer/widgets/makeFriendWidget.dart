import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import '../../../constants/style.dart';
import '../../authentication/provider/authProvider.dart';
import '../providers/budyyProvider.dart';

ListTile friendTile(BuildContext context, String userId, String name,
    String image, int mutualFriends, VoidCallback func) {
  return ListTile(
    leading: CircleAvatar(
      radius: 31,
      backgroundImage: NetworkImage(image),
    ),
    title: Text(
      name,
      style: customTextStyle(14, FontWeight.w600),
    ),
    subtitle: Text(
      '$mutualFriends Mutual Friends',
      style: customTextStyle(11, FontWeight.w500),
    ),
    trailing: Provider.of<BuddyProvider>(context, listen: false).isBuddy(userId)
        ? const Padding(
            padding: EdgeInsets.only(right: 12.5),
            child: Text('Added'),
          )
        : ElevatedButton(
            onPressed: () {
              UIBlock.block(context);
              Provider.of<BuddyProvider>(context, listen: false)
                  .addBuddy(
                      userId,
                      Provider.of<AuthProvider>(context, listen: false)
                          .localUser
                          .token!)
                  .then((value) {
                if (value) {
                  UIBlock.unblock(context);
                  func();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Buddy added!'),
                    ),
                  );
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Add',
              style: customTextStyle(11, FontWeight.w500),
            ),
          ),
  );
}
