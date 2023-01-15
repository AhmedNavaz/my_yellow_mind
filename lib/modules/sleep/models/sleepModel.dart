import 'package:my_yellow_mind/modules/sleep/models/sleepCategories.dart';
import 'package:my_yellow_mind/modules/sleep/models/userFavoritesModel.dart';

import '../../../models/responseModel.dart';

class SleepModel {
  List<SleepCategories>? mindCategories;
  Null? vidAudFilesDto;
  Null? featuredVideo;
  List<SpUserVidAudWatchCountDtos>? spUserVidAudWatchCountDtos;
  List<UserFavorites>? userFavorites;
  Null? vidAudFilesDtoList;
  Null? qoutesDto;
  Null? moodCheckDto;
  Null? spCBTSessionDtos;
  String? imagePath;
  String? videoPath;
  ResponseDto? responseDto;

  SleepModel(
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

  SleepModel.fromJson(Map<String, dynamic> json) {
    if (json['mindCategories'] != null) {
      mindCategories = <SleepCategories>[];
      json['mindCategories'].forEach((v) {
        mindCategories!.add(new SleepCategories.fromJson(v));
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
    if (json['userFavorites'] != null) {
      userFavorites = <UserFavorites>[];
      json['userFavorites'].forEach((v) {
        userFavorites!.add(new UserFavorites.fromJson(v));
      });
    }
    vidAudFilesDtoList = json['vidAudFilesDtoList'];
    qoutesDto = json['qoutesDto'];
    moodCheckDto = json['moodCheckDto'];
    spCBTSessionDtos = json['spCBTSessionDtos'];
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
    if (this.userFavorites != null) {
      data['userFavorites'] =
          this.userFavorites!.map((v) => v.toJson()).toList();
    }
    data['vidAudFilesDtoList'] = this.vidAudFilesDtoList;
    data['qoutesDto'] = this.qoutesDto;
    data['moodCheckDto'] = this.moodCheckDto;
    data['spCBTSessionDtos'] = this.spCBTSessionDtos;
    data['imagePath'] = this.imagePath;
    data['videoPath'] = this.videoPath;
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    return data;
  }
}

class SpUserVidAudWatchCountDtos {
  int? videoId;
  int? noOfWatch;
  int? startTime;
  int? watchTime;
  String? title;
  String? description;
  int? duration;
  String? category;
  String? imageFile;
  String? vidAudFile;
  bool? isFeatured;
  String? subCategory;
  String? type;

  SpUserVidAudWatchCountDtos(
      {this.videoId,
      this.noOfWatch,
      this.startTime,
      this.watchTime,
      this.title,
      this.description,
      this.duration,
      this.category,
      this.imageFile,
      this.vidAudFile,
      this.isFeatured,
      this.subCategory,
      this.type});

  SpUserVidAudWatchCountDtos.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    noOfWatch = json['noOfWatch'];
    startTime = json['startTime'];
    watchTime = json['watchTime'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    category = json['category'];
    imageFile = json['imageFile'];
    vidAudFile = json['vidAudFile'];
    isFeatured = json['isFeatured'];
    subCategory = json['subCategory'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['noOfWatch'] = this.noOfWatch;
    data['startTime'] = this.startTime;
    data['watchTime'] = this.watchTime;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['category'] = this.category;
    data['imageFile'] = this.imageFile;
    data['vidAudFile'] = this.vidAudFile;
    data['isFeatured'] = this.isFeatured;
    data['subCategory'] = this.subCategory;
    data['type'] = this.type;
    return data;
  }
}
