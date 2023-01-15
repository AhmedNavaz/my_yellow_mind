import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_yellow_mind/modules/settings/models/mindCategoryModel.dart';

import '../../../constants/api.dart';

class CategoriesProvider extends ChangeNotifier {
  List<CategoryDtoList> categories = [];

  Future<MindCategoriesModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/Category/mind',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        MindCategoriesModel mindCategoriesModel =
            MindCategoriesModel.fromJson(responseData);
        categories = mindCategoriesModel.categoryDtoList!;
        notifyListeners();
        return mindCategoriesModel;
      }
      return MindCategoriesModel();
    } catch (e) {
      print(e);
      return MindCategoriesModel();
    }
  }
}
