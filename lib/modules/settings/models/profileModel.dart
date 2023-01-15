import '../../../models/responseModel.dart';

class ProfileModel {
  UserDto? userDto;
  Null? userDtoList;
  ResponseDto? responseDto;
  Null? userTokens;

  ProfileModel(
      {this.userDto, this.userDtoList, this.responseDto, this.userTokens});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userDto =
        json['userDto'] != null ? new UserDto.fromJson(json['userDto']) : null;
    userDtoList = json['userDtoList'];
    responseDto = json['responseDto'] != null
        ? new ResponseDto.fromJson(json['responseDto'])
        : null;
    userTokens = json['userTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDto != null) {
      data['userDto'] = this.userDto!.toJson();
    }
    data['userDtoList'] = this.userDtoList;
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    data['userTokens'] = this.userTokens;
    return data;
  }
}

class UserDto {
  String? id;
  String? name;
  String? email;
  String? password;
  Null? gender;
  Null? zipCode;
  int? age;
  int? weight;
  int? height;
  Null? dob;
  bool? emailVerify;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  String? modifiedAt;

  UserDto(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.gender,
      this.zipCode,
      this.age,
      this.weight,
      this.height,
      this.dob,
      this.emailVerify,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    zipCode = json['zipCode'];
    age = json['age'];
    weight = json['weight'];
    height = json['height'];
    dob = json['dob'];
    emailVerify = json['emailVerify'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['zipCode'] = this.zipCode;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['dob'] = this.dob;
    data['emailVerify'] = this.emailVerify;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
