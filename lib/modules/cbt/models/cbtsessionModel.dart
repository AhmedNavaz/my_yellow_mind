class SpCBTSessionDtos {
  String? title;
  String? categoryName;
  String? fileName;
  int? sessionId;
  int? slotId;
  String? startAt;
  String? endAt;
  int? targetParticipants;
  int? participants;
  String? vidAudFile;

  SpCBTSessionDtos(
      {this.title,
      this.categoryName,
      this.fileName,
      this.sessionId,
      this.slotId,
      this.startAt,
      this.endAt,
      this.targetParticipants,
      this.participants,
      this.vidAudFile});

  SpCBTSessionDtos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    categoryName = json['categoryName'];
    fileName = json['fileName'];
    sessionId = json['sessionId'];
    slotId = json['slotId'];
    startAt = json['startAt'];
    endAt = json['endAt'];
    targetParticipants = json['targetParticipants'];
    participants = json['participants'];
    vidAudFile = json['vidAudFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['categoryName'] = this.categoryName;
    data['fileName'] = this.fileName;
    data['sessionId'] = this.sessionId;
    data['slotId'] = this.slotId;
    data['startAt'] = this.startAt;
    data['endAt'] = this.endAt;
    data['targetParticipants'] = this.targetParticipants;
    data['participants'] = this.participants;
    data['vidAudFile'] = this.vidAudFile;
    return data;
  }
}
