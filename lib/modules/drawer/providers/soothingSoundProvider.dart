import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_yellow_mind/modules/drawer/models/soothingSoundData.dart';
import 'package:my_yellow_mind/modules/drawer/models/soothingSoundModel.dart';

import '../../../constants/api.dart';

class SoothingSoundProvider extends ChangeNotifier {
  var soothingSoundList = soothingSoundData;
  var soothingSoundFavorite = soothingSoundFavorites;

  List<VidAudFilesDtoList> soothingSounds = [];
  List<UserFavorites> userFavorites = [];

  var imagePath;
  var videoPath;
  Future<SoothingSoundModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/vidaudfiles/southingsounds',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        SoothingSoundModel soothingSoundModel =
            SoothingSoundModel.fromJson(responseData);
        soothingSounds = soothingSoundModel.vidAudFilesDtoList!;
        userFavorites = soothingSoundModel.userFavorites!;
        imagePath = soothingSoundModel.imagePath;
        videoPath = soothingSoundModel.videoPath;
        notifyListeners();
        return soothingSoundModel;
      }
      return SoothingSoundModel();
    } catch (e) {
      print(e);
      return SoothingSoundModel();
    }
  }
}
