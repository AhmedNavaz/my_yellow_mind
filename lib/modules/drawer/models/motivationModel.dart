import '../../../models/responseModel.dart';

class MotivationModel {
  Null? mindCategories;
  Null? vidAudFilesDto;
  Null? featuredVideo;
  Null? spUserVidAudWatchCountDtos;
  Null? userFavorites;
  List<VidAudFilesDtoList>? vidAudFilesDtoList;
  Null? qoutesDto;
  Null? moodCheckDto;
  Null? spCBTSessionDtos;
  String? imagePath;
  String? videoPath;
  ResponseDto? responseDto;

  MotivationModel(
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

  MotivationModel.fromJson(Map<String, dynamic> json) {
    mindCategories = json['mindCategories'];
    vidAudFilesDto = json['vidAudFilesDto'];
    featuredVideo = json['featuredVideo'];
    spUserVidAudWatchCountDtos = json['spUserVidAudWatchCountDtos'];
    userFavorites = json['userFavorites'];
    if (json['vidAudFilesDtoList'] != null) {
      vidAudFilesDtoList = <VidAudFilesDtoList>[];
      json['vidAudFilesDtoList'].forEach((v) {
        vidAudFilesDtoList!.add(new VidAudFilesDtoList.fromJson(v));
      });
    }
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
    data['mindCategories'] = this.mindCategories;
    data['vidAudFilesDto'] = this.vidAudFilesDto;
    data['featuredVideo'] = this.featuredVideo;
    data['spUserVidAudWatchCountDtos'] = this.spUserVidAudWatchCountDtos;
    data['userFavorites'] = this.userFavorites;
    if (this.vidAudFilesDtoList != null) {
      data['vidAudFilesDtoList'] =
          this.vidAudFilesDtoList!.map((v) => v.toJson()).toList();
    }
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

class VidAudFilesDtoList {
  int? id;
  String? title;
  String? type;
  String? description;
  int? duration;
  String? vidAudFile;
  String? imageFile;
  String? category;
  String? subCategory;
  bool? isFeatured;
  int? calories;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  VidAudFilesDtoList(
      {this.id,
      this.title,
      this.type,
      this.description,
      this.duration,
      this.vidAudFile,
      this.imageFile,
      this.category,
      this.subCategory,
      this.isFeatured,
      this.calories,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  VidAudFilesDtoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    description = json['description'];
    duration = json['duration'];
    vidAudFile = json['vidAudFile'];
    imageFile = json['imageFile'];
    category = json['category'];
    subCategory = json['subCategory'];
    isFeatured = json['isFeatured'];
    calories = json['calories'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['vidAudFile'] = this.vidAudFile;
    data['imageFile'] = this.imageFile;
    data['category'] = this.category;
    data['subCategory'] = this.subCategory;
    data['isFeatured'] = this.isFeatured;
    data['calories'] = this.calories;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
