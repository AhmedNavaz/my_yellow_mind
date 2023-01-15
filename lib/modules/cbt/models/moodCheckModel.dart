class MoodCheckDto {
  int? id;
  String? userId;
  String? mood;
  int? sleep;
  int? progress;
  int? activity;
  Null? createdBy;
  String? createdAt;
  Null? modifiedBy;
  Null? modifiedAt;

  MoodCheckDto(
      {this.id,
      this.userId,
      this.mood,
      this.sleep,
      this.progress,
      this.activity,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifiedAt});

  MoodCheckDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    mood = json['mood'];
    sleep = json['sleep'];
    progress = json['progress'];
    activity = json['activity'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    modifiedBy = json['modifiedBy'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['mood'] = this.mood;
    data['sleep'] = this.sleep;
    data['progress'] = this.progress;
    data['activity'] = this.activity;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedAt'] = this.modifiedAt;
    return data;
  }
}
