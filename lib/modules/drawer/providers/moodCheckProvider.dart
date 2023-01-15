import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/api.dart';

class MoodCheckProvider extends ChangeNotifier {
  Future<bool> setMood(String mood, String token) async {
    try {
      Map<String, dynamic> data = {
        "Mood": mood,
      };
      var response = await Dio().post('$API_URL/usermoodcheck',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
