import '../../../models/responseModel.dart';

class SubscriptionModel {
  Null? packagesDto;
  List<PackagesDtoList>? packagesDtoList;
  ResponseDto? responseDto;

  SubscriptionModel({this.packagesDto, this.packagesDtoList, this.responseDto});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    packagesDto = json['packagesDto'];
    if (json['packagesDtoList'] != null) {
      packagesDtoList = <PackagesDtoList>[];
      json['packagesDtoList'].forEach((v) {
        packagesDtoList!.add(new PackagesDtoList.fromJson(v));
      });
    }
    responseDto = json['responseDto'] != null
        ? new ResponseDto.fromJson(json['responseDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packagesDto'] = this.packagesDto;
    if (this.packagesDtoList != null) {
      data['packagesDtoList'] =
          this.packagesDtoList!.map((v) => v.toJson()).toList();
    }
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    return data;
  }
}

class PackagesDtoList {
  int? id;
  String? title;
  String? description;
  double? price;
  int? duration;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  PackagesDtoList(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.duration,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  PackagesDtoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'].toDouble();
    duration = json['duration'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['duration'] = this.duration;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
