import 'package:flutter/material.dart';
import 'package:realtime_chat/data/user_data.dart';
import 'package:realtime_chat/model/user_model.dart';

class AuthLoginProvider extends ChangeNotifier {
  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  UserModel? userLoginNow;

  TextEditingController etUsernameRegister = TextEditingController();
  TextEditingController etEmailRegister = TextEditingController();
  TextEditingController etPasswordRegiser = TextEditingController();
  TextEditingController etConfirmPasswordRegiser = TextEditingController();
  String errorMessage = '';

  Future<bool> registerUser() async {
    if (etUsernameRegister.text.trim() == '' ||
        etEmailRegister.text.trim() == '' ||
        etPasswordRegiser.text.trim() == '' ||
        etConfirmPasswordRegiser.text.trim() == '') {
      errorMessage = "Field Tidak Bolehh Kosong";
      return false;
    } else if (etPasswordRegiser.text != etConfirmPasswordRegiser.text) {
      errorMessage = "Password dan Confirm Password Harus Sama";
      return false;
    } else {
      UserModel? data = await UserData().registerUser(etUsernameRegister.text,
          etEmailRegister.text, etPasswordRegiser.text);
      if (data != null) {
        userLoginNow = data;
        return true;
      } else {
        errorMessage = 'Internal Server Error';
        return false;
      }
    }
  }

  Future<bool> loginAction() async {
    UserModel? data = await UserData().loginUser(etEmail.text, etPassword.text);

    if (data != null) {
      userLoginNow = data;
      return true;
    } else {
      return false;
    }
  }
}
