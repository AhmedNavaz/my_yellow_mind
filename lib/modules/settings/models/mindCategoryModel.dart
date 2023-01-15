import '../../../models/responseModel.dart';

class MindCategoriesModel {
  Null? categoryDto;
  List<CategoryDtoList>? categoryDtoList;
  ResponseDto? responseDto;
  Null? userTokens;

  MindCategoriesModel(
      {this.categoryDto,
      this.categoryDtoList,
      this.responseDto,
      this.userTokens});

  MindCategoriesModel.fromJson(Map<String, dynamic> json) {
    categoryDto = json['categoryDto'];
    if (json['categoryDtoList'] != null) {
      categoryDtoList = <CategoryDtoList>[];
      json['categoryDtoList'].forEach((v) {
        categoryDtoList!.add(new CategoryDtoList.fromJson(v));
      });
    }
    responseDto = json['responseDto'] != null
        ? new ResponseDto.fromJson(json['responseDto'])
        : null;
    userTokens = json['userTokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryDto'] = this.categoryDto;
    if (this.categoryDtoList != null) {
      data['categoryDtoList'] =
          this.categoryDtoList!.map((v) => v.toJson()).toList();
    }
    if (this.responseDto != null) {
      data['responseDto'] = this.responseDto!.toJson();
    }
    data['userTokens'] = this.userTokens;
    return data;
  }
}

class CategoryDtoList {
  int? id;
  String? name;
  String? type;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  CategoryDtoList(
      {this.id,
      this.name,
      this.type,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  CategoryDtoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
