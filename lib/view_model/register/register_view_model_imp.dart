import 'package:dotnet_test/model/login_model.dart';
import 'package:dotnet_test/model/login_result_model.dart';
import 'package:dotnet_test/model/register_model.dart';
import 'package:dotnet_test/model/register_result_model.dart';
import 'package:dotnet_test/network/register.dart';
import 'package:dotnet_test/view_model/register/register_view_model.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterViewModelImp implements RegisterViewModel
{
  @override
  Future<RegisterResultModel> registerUser(RegisterModel loginModel) {
    return Register(loginModel);
  }
}