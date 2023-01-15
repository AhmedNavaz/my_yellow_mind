import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_yellow_mind/modules/sleep/models/sleepCategories.dart';

import '../../../constants/api.dart';
import '../models/sleepModel.dart';
import '../models/sleepMusicData.dart';
import '../models/userFavoritesModel.dart';

class SleepProvider extends ChangeNotifier {
  var sleepMusicList = sleepStoriesData;

  var imagePath;
  var videoPath;
  List<UserFavorites> userFavorites = [];
  List<SleepCategories> sleepCategories = [];
  List<SpUserVidAudWatchCountDtos> sleepAudios = [];

  Future<SleepModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/vidaudfiles/Sleep',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        SleepModel sleepModel = SleepModel.fromJson(responseData);
        userFavorites = sleepModel.userFavorites!;
        sleepCategories = sleepModel.mindCategories!;
        sleepAudios = sleepModel.spUserVidAudWatchCountDtos!;
        imagePath = sleepModel.imagePath!;
        videoPath = sleepModel.videoPath!;
        notifyListeners();
        return sleepModel;
      }
      return SleepModel();
    } catch (e) {
      print(e);
      return SleepModel();
    }
  }

  Future<List<SpUserVidAudWatchCountDtos>> getCategoryData(String name) {
    return Future.value(
        sleepAudios.where((element) => element.subCategory == name).toList());
  }

  // Add to favorites
  Future<bool> addToFavorites(int id, String token) async {
    try {
      Map<String, dynamic> data = {
        "VidAudId": id,
      };
      var response = await Dio().post('$API_URL/userfavorite',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        userFavorites.add(UserFavorites(videoId: id));
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

  // Add to favorites
  Future<bool> removeFromFavorites(int id, String token) async {
    try {
      Map<String, dynamic> data = {
        "VidAudId": id,
      };
      var response = await Dio().post('$API_URL/userfavorite',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        userFavorites.remove(UserFavorites(videoId: id));
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

  // present in userFavorites
  bool isFavorite(int id) {
    return userFavorites.any((element) => element.videoId == id);
  }
}
