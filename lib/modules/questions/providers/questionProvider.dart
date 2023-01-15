import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../../constants/api.dart';

class QuestionProvider extends ChangeNotifier {
  int currentQuestion = 0;
  String? answer;
  List<String> selectedCategores = [];

  var email;
  var password;

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void empty() {
    selectedCategores = [];
    notifyListeners();
  }

  void addCategory(String value) {
    selectedCategores.add(value);
    notifyListeners();
  }

  void changeCurrentQuestion(int value) {
    currentQuestion = value;
    notifyListeners();
  }

  void changeUserName(String value) {
    notifyListeners();
  }

  void setAnswer(String value) {
    answer = value;
    notifyListeners();
  }

  Future<bool> addUserCategories(String token, String a) async {
    try {
      Map<String, dynamic> data = {
        "categories": a,
      };
      FormData formData = FormData.fromMap(data);
      var response = await Dio().patch('$API_URL/user/Category',
          data: formData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
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

  Future<bool> saveAnswer(int id, String answer, String token) async {
    try {
      Map<String, dynamic> data = {"QuestionId": id, "Answer": answer};
      var response = await Dio().post('$API_URL/questionanswers',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getQuestions(String token) async {
    try {
      var response = await Dio().get('$API_URL/questionair',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        print(responseData);
      }
    } catch (e) {
      print(e);
    }
  }
}
