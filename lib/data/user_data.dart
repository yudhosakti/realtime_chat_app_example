import 'dart:convert';
import 'dart:developer';

import 'package:realtime_chat/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserData {
  String baseIp = "http://localhost:4000";

  Future<UserModel?> loginUser(String email, String password) async {
    UserModel? userModel;
    var fetchLoginApi = await http.post(
        body: jsonEncode({"email": email, "password": password}),
        Uri.parse("${baseIp}/person/login"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        });
    if (fetchLoginApi.statusCode == 200) {
      var jsonData = jsonDecode(fetchLoginApi.body);
      userModel = UserModel.getDataFromJSON(jsonData['data']);
      return userModel;
    } else {
      return userModel;
    }
  }

  Future<UserModel?> registerUser(
      String username, String email, String password) async {
    UserModel? userModel;
    var response = await http.post(Uri.parse("$baseIp/person/register"),
        body: jsonEncode(
            {"username": username, "email": email, "password": password}),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      userModel = UserModel.getDataFromJSON(jsonData);
      return userModel;
    } else {
      return userModel;
    }
  }
}
