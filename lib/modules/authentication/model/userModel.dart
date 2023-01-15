class UserModel {
  String? userId;
  String? name;
  String? email;
  String? token;

  UserModel({this.userId, this.name, this.email, this.token});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
