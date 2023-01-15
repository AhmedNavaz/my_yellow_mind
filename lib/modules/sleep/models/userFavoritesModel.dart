class UserFavorites {
  int? videoId;
  int? noOfWatch;
  Null? startTime;
  Null? watchTime;
  String? title;
  String? description;
  int? duration;
  String? category;
  String? imageFile;
  String? vidAudFile;
  bool? isFeatured;
  String? subCategory;
  String? type;

  UserFavorites(
      {this.videoId,
      this.noOfWatch,
      this.startTime,
      this.watchTime,
      this.title,
      this.description,
      this.duration,
      this.category,
      this.imageFile,
      this.vidAudFile,
      this.isFeatured,
      this.subCategory,
      this.type});

  UserFavorites.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    noOfWatch = json['noOfWatch'];
    startTime = json['startTime'];
    watchTime = json['watchTime'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    category = json['category'];
    imageFile = json['imageFile'];
    vidAudFile = json['vidAudFile'];
    isFeatured = json['isFeatured'];
    subCategory = json['subCategory'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['noOfWatch'] = this.noOfWatch;
    data['startTime'] = this.startTime;
    data['watchTime'] = this.watchTime;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['category'] = this.category;
    data['imageFile'] = this.imageFile;
    data['vidAudFile'] = this.vidAudFile;
    data['isFeatured'] = this.isFeatured;
    data['subCategory'] = this.subCategory;
    data['type'] = this.type;
    return data;
  }
}