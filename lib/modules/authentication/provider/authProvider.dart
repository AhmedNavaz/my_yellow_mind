import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:my_yellow_mind/modules/authentication/model/userModel.dart';

import '../../../constants/api.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _googleUser;
  UserModel localUser = UserModel();

  set user(Map<dynamic, dynamic> user) {
    localUser = UserModel.fromJson(user);
    notifyListeners();
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      Map<String, dynamic> data = {
        'Name': name,
        'Email': email,
        'Password': password,
      };
      var response = await Dio().post(
        '$API_URL/user',
        data: data,
      );
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        localUser = UserModel(
          userId: responseData["userTokens"]["id"],
          name: name,
          email: email,
          token: responseData["userTokens"]["token"],
        );
        var box = await Hive.openBox('user');
        box.put('user', localUser.toJson());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      Map<String, dynamic> data = {
        'UserName': email,
        'Password': password,
      };
      var response = await Dio().post(
        '$API_URL/account',
        data: data,
      );
      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        localUser = UserModel(
          userId: responseData["userTokens"]["id"],
          name: responseData["userTokens"]["userName"],
          email: email,
          token: responseData["userTokens"]["token"],
        );
        var box = await Hive.openBox('user');
        box.put('user', localUser.toJson());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> googleLogin() async {
    try {
      String resp = '';
      final user = await googleSignin.signIn();
      if (user == null) return 'error';
      _googleUser = user;

      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential).then((value) async {
        print(_auth.currentUser!.email);
        Map<String, dynamic> data = {
          'UserName': _auth.currentUser!.email,
        };
        FormData formData = FormData.fromMap(data);
        var response = await Dio().post(
          '$API_URL/account/other',
          data: formData,
        );
        Map<String, dynamic> responseData = response.data;
        print(responseData);
        if (responseData["responseDto"]["status"]) {
          localUser = UserModel(
            userId: responseData["userTokens"]["id"],
            name: _auth.currentUser!.displayName,
            email: _auth.currentUser!.email,
            token: responseData["userTokens"]["token"],
          );
          var box = await Hive.openBox('user');
          box.put('user', localUser.toJson());
          notifyListeners();
          return 'success';
        } else {
          await signUp(_auth.currentUser!.displayName!,
                  _auth.currentUser!.email!, '')
              .then((value) {
            value ? resp = 'new' : resp = 'error';
          });
        }
      });
      return resp;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  Future<String> facebookLogin() async {
    String resp = '';
    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final credential = FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await _auth.signInWithCredential(credential).then((value) async {
        print(_auth.currentUser!.email);
        Map<String, dynamic> data = {
          'UserName': _auth.currentUser!.email,
        };
        FormData formData = FormData.fromMap(data);
        var response = await Dio().post(
          '$API_URL/account/other',
          data: formData,
        );
        Map<String, dynamic> responseData = response.data;
        print(responseData);
        if (responseData["responseDto"]["status"]) {
          print(responseData);
          localUser = UserModel(
            userId: responseData["userTokens"]["id"],
            name: _auth.currentUser!.displayName,
            email: _auth.currentUser!.email,
            token: responseData["userTokens"]["token"],
          );
          var box = await Hive.openBox('user');
          box.put('user', localUser.toJson());
          notifyListeners();
          return 'success';
        } else {
          await signUp(_auth.currentUser!.displayName!,
                  _auth.currentUser!.email!, '')
              .then((value) {
            value ? resp = 'new' : resp = 'error';
          });
        }
      });
      return resp;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  void signOut() async {
    try {
      var box = await Hive.openBox('user');
      box.delete('user');
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<String> getData(String token) async {
    try {
      var response = await Dio().get('$API_URL/screentext/privacy',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> responseData = response.data;
      if (responseData["responseDto"]["status"]) {
        notifyListeners();
        return responseData["screenTextDto"]["text"];
      }
      return '';
    } catch (e) {
      print(e);
      return '';
    }
  }
}
