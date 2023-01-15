import 'package:my_yellow_mind/modules/cbt/models/moodCheckModel.dart';
import 'package:my_yellow_mind/modules/meditation/models/quotesModel.dart';

import '../../../models/responseModel.dart';
import '../../cbt/models/cbtsessionModel.dart';
import '../../sleep/models/sleepModel.dart';
import 'mindCategoriesModel.dart';

class MeditationModel {
  List<MindCategories>? mindCategories;
  Null? vidAudFilesDto;
  Null? featuredVideo;
  List<SpUserVidAudWatchCountDtos>? spUserVidAudWatchCountDtos;
  Null? userFavorites;
  Null? vidAudFilesDtoList;
  QoutesDto? qoutesDto;
  MoodCheckDto? moodCheckDto;
  List<SpCBTSessionDtos>? spCBTSessionDtos;
  String? imagePath;
  String? videoPath;
  ResponseDto? responseDto;

  MeditationModel(
      {this.mindCategories,
      this.vidAudFilesDto,
      this.featuredVideo,
      this.spUserVidAudWatchCountDtos,
      this.userFavorites,
      this.vidAudFilesDtoList,
      this.qoutesDto,
      this.moodCheckDto,
      this.spCBTSessionDtos,
      this.imagePath,
      this.videoPath,
      this.responseDto});

  MeditationModel.fromJson(Map<String, dynamic> json) {
    if (json['mindCategories'] != null) {
      mindCategories = <MindCategories>[];
      json['mindCategories'].forEach((v) {
        mindCategories!.add(new MindCategories.fromJson(v));
      });
    }
    vidAudFilesDto = json['vidAudFilesDto'];
    featuredVideo = json['featuredVideo'];
    if (json['spUserVidAudWatchCountDtos'] != null) {
      spUserVidAudWatchCountDtos = <SpUserVidAudWatchCountDtos>[];
      json['spUserVidAudWatchCountDtos'].forEach((v) {
        spUserVidAudWatchCountDtos!
            .add(new SpUserVidAudWatchCountDtos.fromJson(v));
      });
    }
    userFavorites = json['userFavorites'];
    vidAudFilesDtoList = json['vidAudFilesDtoList'];
    qoutesDto = json['qoutesDto'] != null
        ? new QoutesDto.fromJson(json['qoutesDto'])
        : null;
    moodCheckDto = json['moodCheckDto'] != null
        ? new MoodCheckDto.fromJson(json['moodCheckDto'])
        : null;
    if (json['spCBTSessionDtos'] != null) {
      spCBTSessionDtos = <SpCBTSessionDtos>[];
      json['spCBTSessionDtos'].forEach((v) {
        spCBTSessionDtos!.add(new SpCBTSessionDtos.fromJson(v));
      });
    }
    imagePath = json['imagePath'];
    videoPath = json['videoPath'];
    responseDto = json['responseDto'] != null
        ? new ResponseDto.fromJson(json['responseDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mindCategories != null) {
      data['mindCategories'] =
          this.mindCategories!.map((v) => v.toJson()).toList();
    }
    data['vidAudFilesDto'] = this.vidAudFilesDto;
    data['featuredVideo'] = this.featuredVideo;
    if (this.spUserVidAudWatchCountDtos != null) {
      data['spUserVidAudWatchCountDtos'] =
          this.spUserVidAudWatchCountDtos!.map((v) => v.toJson()).toList();
    }
    data['userFavorites'] = this.userFavorites;
    data['vidAudFilesDtoList'] = this.vidAudFilesDtoList;
    if (this.qoutesDto != null) {
      data['qoutesDto'] = this.qoutesDto!.toJson();
    }
    if (this.moodCheckDto != null) {
      data['moodCheckDto'] = this.moodCheckDto!.toJson();
    }
    if (this.spCBTSessionDtos != null) {
      data['spCBTSessionDtos'] =
          this.spCBTSessionDtos!.map((v) => v.toJson()).toList();
    }
    data['imagePath'] = this.imagePath;
    data['videoPath'] = this.videoPath;
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    return data;
  }
}
