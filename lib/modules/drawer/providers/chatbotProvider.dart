import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/api.dart';

class ChatbotProvider extends ChangeNotifier {
  List<dynamic> currentQuestion = [
    {'dialogue': 'Are you feeling lonely?', 'answer': null}
  ];
  List<String> currentOptions = ['Yes', 'No'];
  Future<void> askChatbot(String question, String answer, String token) async {
    try {
      Map<String, dynamic> data = {"Dialogue": question, "Answer": answer};
      var response = await Dio().post('$API_URL/user/chatbot',
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      var responseData = response.data;
      currentQuestion.clear();
      currentOptions.clear();
      for (final data in responseData) {
        if (data['dialogue'][0] == '[') {
          String temp = data['dialogue'];
          temp = temp.substring(1, temp.length - 1);
          currentOptions = temp.split(',');
        } else {
          currentQuestion.add(data);
        }
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
