import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_yellow_mind/modules/cbt/models/cbtsessionModel.dart';

import '../../../constants/api.dart';
import '../models/liveSessionData.dart';

class CBTProvider extends ChangeNotifier {
  var liveSessionList = liveSessionData;

  var imagePath;
  var videoPath;

  Future<List<SpCBTSessionDtos>> getCbtSessions(String token) async {
    try {
      var response = await Dio().get('$API_URL/cbtsession',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        List<SpCBTSessionDtos> sessions = [];
        imagePath = responseData["imagePath"];
        videoPath = responseData["videoPath"];
        for (var session in responseData["spCBTSessionDtos"]) {
          sessions.add(SpCBTSessionDtos.fromJson(session));
        }
        return sessions;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  void addTextToMessages(String text) {
    liveSessionList[0]['messages'].add({
      'id': liveSessionList[0]['messages'].length + 1,
      'image':
          'https://media.istockphoto.com/id/1347495868/photo/smiling-african-american-man-wearing-glasses.jpg?b=1&s=170667a&w=0&k=20&c=CVpXibLIGjpa2_sFFgt_ejrz06ULDMZy0ylqK-VnZRU=',
      'text': text,
    });
    notifyListeners();
  }
}
