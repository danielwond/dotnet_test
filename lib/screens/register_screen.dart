import 'package:dotnet_test/model/login_model.dart';
import 'package:dotnet_test/model/register_model.dart';
import 'package:dotnet_test/view_model/register/register_view_model.dart';
import 'package:dotnet_test/view_model/register/register_view_model_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotnet_test/utils/utils.dart';

class RegisterPage extends ConsumerWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final registerViewModel = RegisterViewModelImp();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.cyan,
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Register',
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: accountController,
                            validator: (value) {
                              if (!value!.isValidEmail())
                                return 'Please enter a valid email ';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: "Email"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (!value!.isValidStrongPassword())
                                return 'Please enter a strong password ';
                              else
                                return null;
                            },
                            controller: passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              hintText: "Password",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value != passwordController.text) {
                                return 'Passwords dont match';
                              }
                            },
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              hintText: "Confirm Password",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: "First Name"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: "Last Name"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: "Phone"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  var registerModel = RegisterModel(
                                    accountController.text,
                                    passwordController.text,
                                    firstNameController.text,
                                    lastNameController.text,
                                    phoneNumberController.text,
                                  );
                                  var result = await registerViewModel
                                      .registerUser(registerModel);
                                  if (result.statusCode == 201) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text("all validated")))
                                        .closed
                                        .then((value) {
                                      Navigator.of(context).pop();
                                      print('THISS $value');
                                    });
                                  } else
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(result.message)))
                                        .closed
                                        .then((value) =>
                                            Navigator.of(context).pop());
                                }
                              },
                              child: Text("Register"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Register"),
      ),
    ));
  }
}
