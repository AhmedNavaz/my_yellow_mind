import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_yellow_mind/modules/drawer/models/buddyModel.dart';

import '../../../constants/api.dart';

class BuddyProvider extends ChangeNotifier {
  List<SpUserFollowersDtos> all_users = [];
  Future<BuddyModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/followers',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        BuddyModel buddyModel = BuddyModel.fromJson(responseData);
        all_users = buddyModel.spUserFollowersDtos!;
        print(all_users);
        notifyListeners();
        return buddyModel;
      }
      return BuddyModel();
    } catch (e) {
      print(e);
      return BuddyModel();
    }
  }

  Future<bool> addBuddy(String buddyId, String token) async {
    try {
      Map<String, dynamic> data = {
        "FollowerId": buddyId,
      };
      var response = await Dio().post('$API_URL/followers',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool isBuddy(String buddyId) {
    try {
      for (var i = 0; i < all_users.length; i++) {
        if (all_users[i].followerId == buddyId &&
            all_users[i].isFollowing == true) {
          return true;
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
