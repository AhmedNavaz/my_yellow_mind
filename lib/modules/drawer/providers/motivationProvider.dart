import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/api.dart';
import '../models/motivationModel.dart';

class MotivationProvider extends ChangeNotifier {
  List<VidAudFilesDtoList> vidAudFilesDtoList = [];

  var imagePath;
  var videoPath;
  Future<MotivationModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/vidaudfiles/motivation',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        MotivationModel motivationModel =
            MotivationModel.fromJson(responseData);
        vidAudFilesDtoList = motivationModel.vidAudFilesDtoList!;
        imagePath = motivationModel.imagePath;
        videoPath = motivationModel.videoPath;
        notifyListeners();
        return motivationModel;
      }
      return MotivationModel();
    } catch (e) {
      print(e);
      return MotivationModel();
    }
  }
}
