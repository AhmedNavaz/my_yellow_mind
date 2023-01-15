class QoutesDto {
  int? id;
  String? text;
  String? type;
  String? category;
  String? day;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  QoutesDto(
      {this.id,
      this.text,
      this.type,
      this.category,
      this.day,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  QoutesDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    type = json['type'];
    category = json['category'];
    day = json['day'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['type'] = this.type;
    data['category'] = this.category;
    data['day'] = this.day;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
