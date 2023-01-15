import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_yellow_mind/modules/settings/models/profileModel.dart';

import '../../../constants/api.dart';

class ProfileProvider extends ChangeNotifier {
  UserDto userDto = UserDto();

  Future<ProfileModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/user/getbyid',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        ProfileModel profileModel = ProfileModel.fromJson(responseData);
        userDto = profileModel.userDto!;
        print(userDto.toJson());
        return profileModel;
      }
      return ProfileModel();
    } catch (e) {
      print(e);
      return ProfileModel();
    }
  }

  Future<bool> changeName(String name, String token) async {
    try {
      Map<String, dynamic> data = {
        "Name": name,
      };
      FormData formData = FormData.fromMap(data);
      var response = await Dio().patch('$API_URL/user/Name',
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        userDto.name = name;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changeWeight(int weight, String token) async {
    try {
      Map<String, dynamic> data = {
        "Weight": weight,
      };
      FormData formData = FormData.fromMap(data);
      var response = await Dio().patch('$API_URL/user/Weight',
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        userDto.weight = weight;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changeHeight(int height, String token) async {
    try {
      Map<String, dynamic> data = {
        "Height": height,
      };
      FormData formData = FormData.fromMap(data);
      var response = await Dio().patch('$API_URL/user/Height',
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        // userDto.height = height;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changeAge(int age, String token) async {
    try {
      Map<String, dynamic> data = {
        "Age": age,
      };
      FormData formData = FormData.fromMap(data);
      var response = await Dio().patch('$API_URL/user/Age',
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        userDto.age = age;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
