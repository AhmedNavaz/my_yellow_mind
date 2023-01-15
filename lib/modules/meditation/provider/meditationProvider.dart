import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_yellow_mind/constants/api.dart';
import 'package:my_yellow_mind/modules/cbt/models/moodCheckModel.dart';
import 'package:my_yellow_mind/modules/meditation/models/mindCategoriesModel.dart';
import 'package:my_yellow_mind/modules/meditation/models/quotesModel.dart';
import 'package:my_yellow_mind/modules/sleep/models/sleepModel.dart';

import '../../cbt/models/cbtsessionModel.dart';
import '../models/meditationModel.dart';
import '../models/relatedData.dart';

class MeditationProvider extends ChangeNotifier {
  var musicList = musicData;
  var meditationList = meditationData;

  var imagePath;
  var videoPath;
  List<MindCategories> mindCategories = [];
  MoodCheckDto moodCheckDto = MoodCheckDto();
  QoutesDto qoutesDto = QoutesDto();
  List<SpCBTSessionDtos> spCBTSessionDtos = [];
  List<SpUserVidAudWatchCountDtos> spUserVidAudWatchCountDtos = [];

  void setMoodCheck(String mood) {
    moodCheckDto.mood = mood;
    notifyListeners();
  }

  Future<MeditationModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/vidaudfiles/meditation',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        MeditationModel meditationModel =
            MeditationModel.fromJson(responseData);
        mindCategories = meditationModel.mindCategories!;
        moodCheckDto = meditationModel.moodCheckDto ?? MoodCheckDto();
        spUserVidAudWatchCountDtos =
            meditationModel.spUserVidAudWatchCountDtos!;
        qoutesDto = meditationModel.qoutesDto!;
        spCBTSessionDtos = meditationModel.spCBTSessionDtos!;
        imagePath = meditationModel.imagePath;
        videoPath = meditationModel.videoPath;
        notifyListeners();
        return meditationModel;
      }
      return MeditationModel();
    } catch (e) {
      print(e);
      return MeditationModel();
    }
  }

  Future<List<SpUserVidAudWatchCountDtos>> getCategoryData(String name) {
    return Future.value(spUserVidAudWatchCountDtos
        .where((element) => element.subCategory == name)
        .toList());
  }
}
