import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dotnet_test/model/login_result_model.dart';
import 'package:dotnet_test/model/register_model.dart';
import 'package:dotnet_test/model/register_result_model.dart';
import 'package:dotnet_test/network/api.dart';

Future<RegisterResultModel> Register(RegisterModel login) async {
  var dataSubmit = {'Email': login.email, 'Password': login.password, "FirstName": login.firstName,"LastName": login.lastName,"PhoneNumber": login.phoneNumber };
  var result = await Dio().post(
      '$mainAPI$registerAPI',
      options: Options(
        headers: {
          Headers.contentTypeHeader: "application/json",
          Headers.acceptHeader: "application/json"
        },
        followRedirects: false,
        validateStatus: (status) => status! < 500,
      ),
      data: jsonEncode(dataSubmit)
  );
  if(result.statusCode == 201)
  {
    return RegisterResultModel(201, "Register Success");
  }
  else if(result.statusCode == 409)
  {
    return RegisterResultModel(409, "Email is already registered");
  }
  else
    return RegisterResultModel(result.statusCode!.toInt(), result.data.toString());
}
