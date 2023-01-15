import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/drawer/models/friendsData.dart';

class FriendsProvider extends ChangeNotifier {
  var friendsList = friendsData;

  void addMessage(int id, String message) {
    for (var element in friendsList) {
      if (element['id'] == id) {
        element['messages'].add({
          'message': message,
          'time': DateTime.now(),
          'isMe': true,
        });
      }
    }
    notifyListeners();
  }
}
