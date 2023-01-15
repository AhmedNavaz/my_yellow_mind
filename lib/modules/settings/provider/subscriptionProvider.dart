import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_yellow_mind/modules/drawer/providers/database.dart';
import 'package:my_yellow_mind/modules/settings/models/activePackage.dart';
import 'package:my_yellow_mind/modules/settings/models/subscriptionModel.dart';

import '../../../constants/api.dart';

class SubscriptionProvider extends ChangeNotifier {
  var freeTrial = false;

  Future<void> setFreeTrial(String token) async {
    await checkFreeTrial(token).then((value) async {
      if(!value){
        freeTrial = false;
        notifyListeners();
      }
      else{
        await FirebaseApi.getRedeemedStatus(token).then((value) {
          freeTrial = value;
          notifyListeners();
        });
      }
    });

  }

  List<PackagesDtoList> packagesDtoList = [];
  List<CustomerPackagesDtoList> activePackages = [];

  Future<SubscriptionModel> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/packages',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        SubscriptionModel subscrptionModel =
            SubscriptionModel.fromJson(responseData);
        packagesDtoList = subscrptionModel.packagesDtoList!;
        notifyListeners();
        return subscrptionModel;
      }
      return SubscriptionModel();
    } catch (e) {
      print(e);
      return SubscriptionModel();
    }
  }

  Future<ActivePackage> getActivePlan(String token) async {
    try {
      var response = await Dio().get('$API_URL/customerpackages',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        ActivePackage activePackage = ActivePackage.fromJson(responseData);
        activePackages = activePackage.customerPackagesDtoList!;
        notifyListeners();
        return activePackage;
      }
      return ActivePackage();
    } catch (e) {
      print(e);
      return ActivePackage();
    }
  }

  Future<void> activateFreeTrial(
      String token, bool status, DateTime endDate) async {
    try {
      FirebaseApi.startFreeTrial(
              token, status, endDate.add(const Duration(days: 3)).toString())
          .then((value) {
        freeTrial = true;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  // check if user free trial expired
  Future<bool> checkFreeTrial(String token) async {
    try {
      return FirebaseApi.getFreeTrialDate(token).then((value) {
        if (value.isAfter(DateTime.now())) {
          return true;
        } else {
          return false;
        }
      });
    } catch (e) {
      print(e);
      return false;
    }
  }
}
