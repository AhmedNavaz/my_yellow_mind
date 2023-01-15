import '../../../models/responseModel.dart';

class DailyMovementModel {
  Null? exerciseDto;
  List<ExerciseDtos>? exerciseDtos;
  ResponseDto? responseDto;
  Null? userTokens;
  String? imagePath;
  String? videoPath;

  DailyMovementModel(
      {this.exerciseDto,
      this.exerciseDtos,
      this.responseDto,
      this.userTokens,
      this.imagePath,
      this.videoPath});

  DailyMovementModel.fromJson(Map<String, dynamic> json) {
    exerciseDto = json['exerciseDto'];
    if (json['exerciseDtos'] != null) {
      exerciseDtos = <ExerciseDtos>[];
      json['exerciseDtos'].forEach((v) {
        exerciseDtos!.add(new ExerciseDtos.fromJson(v));
      });
    }
    responseDto = json['responseDto'] != null
        ? new ResponseDto.fromJson(json['responseDto'])
        : null;
    userTokens = json['userTokens'];
    imagePath = json['imagePath'];
    videoPath = json['videoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exerciseDto'] = this.exerciseDto;
    if (this.exerciseDtos != null) {
      data['exerciseDtos'] = this.exerciseDtos!.map((v) => v.toJson()).toList();
    }
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    data['userTokens'] = this.userTokens;
    data['imagePath'] = this.imagePath;
    data['videoPath'] = this.videoPath;
    return data;
  }
}

class ExerciseDtos {
  int? id;
  String? title;
  String? category;
  int? duration;
  String? fileName;
  Null? vidAudFile;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  ExerciseDtos(
      {this.id,
      this.title,
      this.category,
      this.duration,
      this.fileName,
      this.vidAudFile,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  ExerciseDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    duration = json['duration'];
    fileName = json['fileName'];
    vidAudFile = json['vidAudFile'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['duration'] = this.duration;
    data['fileName'] = this.fileName;
    data['vidAudFile'] = this.vidAudFile;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
