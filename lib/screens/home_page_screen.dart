import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("FrontEnd app")),
      body: Center(
        child: Text("HELLOOOOOO"),
      ),
    ));
  }
}
