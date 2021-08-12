import 'package:dotnet_test/model/login_model.dart';
import 'package:dotnet_test/model/login_result_model.dart';
import 'package:dotnet_test/model/register_model.dart';
import 'package:dotnet_test/model/register_result_model.dart';
import 'package:flutter/material.dart';

abstract class RegisterViewModel{
  Future<RegisterResultModel> registerUser(RegisterModel loginModel);

}