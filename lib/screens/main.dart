import 'dart:io';

import 'package:dotnet_test/model/login_model.dart';
import 'package:dotnet_test/screens/home_page_screen.dart';
import 'package:dotnet_test/screens/register_screen.dart';
import 'package:dotnet_test/state/state.dart';
import 'package:dotnet_test/view_model/main/main_view_model_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/register':
            return PageTransition(
                child: RegisterPage(),
                type: PageTransitionType.fade,
                settings: settings);
          case '/home':
            return PageTransition(
                child: HomeScreen(),
                type: PageTransitionType.fade,
                settings: settings);

          default:
            return null;
        }
      },
      home: MainPage(),
    );
  }
}

class MainPage extends ConsumerWidget {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final mainViewModel = MainViewModelImp();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // TODO: implement build
    var isLoadingWatch = watch(isLoading).state;
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("FrontEnd app")),
      backgroundColor: Colors.indigoAccent,
      body: FutureBuilder(
        future: mainViewModel.checkToken(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var result = snapshot.data as bool;
            if (result)
              return Container();
            else
              return isLoadingWatch
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Login',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: accountController,
                                      decoration: InputDecoration(
                                          prefixIcon:
                                              Icon(Icons.account_circle),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          hintText: "Email"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      obscureText: true,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        hintText: "Password",
                                      ),
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
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          var result =
                                              await mainViewModel.processLogin(
                                                  context,
                                                  new LoginModel(
                                                      accountController.text,
                                                      passwordController.text));
                                          if (result.statusCode == 200) {
                                            await mainViewModel.setToken(
                                                context, result.message);
                                            Navigator.of(context)
                                                .pushNamed('/home');
                                          } else
                                            ScaffoldMessenger.of(
                                                    scaffoldKey.currentContext!)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text(result.message)));
                                        },
                                        child: Text("Login"),
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
                                    InkWell(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '-----REGISTER-----',
                                            style: TextStyle(fontSize: 24),
                                          )
                                        ],
                                      ),onTap: ()=>Navigator.of(context).pushNamed('/register'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
          }
        },
      ),
    ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
