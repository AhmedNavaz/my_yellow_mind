class ResponseDto {
  bool? status;
  String? message;
  int? id;
  String? userId;
  Null? token;

  ResponseDto({this.status, this.message, this.id, this.userId, this.token});

  ResponseDto.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    userId = json['userId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['token'] = this.token;
    return data;
  }
}
