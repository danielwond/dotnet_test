import 'package:dotnet_test/model/login_model.dart';
import 'package:dotnet_test/model/login_result_model.dart';
import 'package:flutter/cupertino.dart';

abstract class MainViewModel{
  Future<LoginResultModel> processLogin(BuildContext context, LoginModel loginModel);
  void changeLoading(BuildContext context);
  Future<void> setToken(BuildContext context, String token);
  Future<bool> checkToken(BuildContext context);
}