class MindCategories {
  int? id;
  String? name;
  String? type;
  String? imageName;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  MindCategories(
      {this.id,
      this.name,
      this.type,
      this.imageName,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  MindCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    imageName = json['imageName'];
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
    data['imageName'] = this.imageName;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
