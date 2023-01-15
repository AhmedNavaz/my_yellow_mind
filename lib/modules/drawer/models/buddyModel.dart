import '../../../models/responseModel.dart';

class BuddyModel {
  Null? followersDto;
  Null? followersDtoList;
  List<SpUserFollowersDtos>? spUserFollowersDtos;
  ResponseDto? responseDto;
  Null? userTokens;

  BuddyModel(
      {this.followersDto,
      this.followersDtoList,
      this.spUserFollowersDtos,
      this.responseDto,
      this.userTokens});

  BuddyModel.fromJson(Map<String, dynamic> json) {
    followersDto = json['followersDto'];
    followersDtoList = json['followersDtoList'];
    if (json['spUserFollowersDtos'] != null) {
      spUserFollowersDtos = <SpUserFollowersDtos>[];
      json['spUserFollowersDtos'].forEach((v) {
        spUserFollowersDtos!.add(new SpUserFollowersDtos.fromJson(v));
      });
    }
    responseDto = json['responseDto'] != null
        ? new ResponseDto.fromJson(json['responseDto'])
        : null;
    userTokens = json['userTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followersDto'] = this.followersDto;
    data['followersDtoList'] = this.followersDtoList;
    if (this.spUserFollowersDtos != null) {
      data['spUserFollowersDtos'] =
          this.spUserFollowersDtos!.map((v) => v.toJson()).toList();
    }
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    data['userTokens'] = this.userTokens;
    return data;
  }
}

class SpUserFollowersDtos {
  String? userId;
  String? name;
  String? email;
  String? followerId;
  bool? isFollowing;

  SpUserFollowersDtos(
      {this.userId, this.name, this.email, this.followerId, this.isFollowing});

  SpUserFollowersDtos.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    followerId = json['followerId'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['followerId'] = this.followerId;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}
