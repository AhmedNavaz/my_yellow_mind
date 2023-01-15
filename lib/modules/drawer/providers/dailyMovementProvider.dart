import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_yellow_mind/modules/drawer/models/yogaModel.dart';

import '../../../constants/api.dart';
import '../models/dailyMovementData.dart';
import '../models/dailyMovementModel.dart';

class DailyMovementProvider extends ChangeNotifier {
  var yogaPlansList = yogaData;
  var runningPlansList = runningData;

  var imagePath;
  var videoPath;

  List<ExerciseDtos> exerciseDtos = [];
  List<VidAudFilesDtoList> yogaList = [];

  Future<DailyMovementModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/exercise',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        DailyMovementModel dailyMovementModel =
            DailyMovementModel.fromJson(responseData);
        exerciseDtos = dailyMovementModel.exerciseDtos!;
        imagePath = dailyMovementModel.imagePath;
        videoPath = dailyMovementModel.videoPath;
        notifyListeners();
        return dailyMovementModel;
      }
      return DailyMovementModel();
    } catch (e) {
      print(e);
      return DailyMovementModel();
    }
  }

  Future<void> getYoga(String token) async {
    try {
      var response = await Dio().get('$API_URL/vidaudfiles',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        YogaModel temp = YogaModel.fromJson(responseData);
        yogaList.clear();
        for (final audio in temp.vidAudFilesDtoList!) {
          if (audio.subCategory == 'breathwork') {
            yogaList.add(audio);
          }
        }
        imagePath = responseData['imagePath'];
        videoPath = responseData['videoPath'];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
