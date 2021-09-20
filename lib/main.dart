import 'package:flutter/material.dart';
import 'package:getapi/AllContries.dart';
import 'package:getapi/Contry.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "AllContries",
      routes: {
        "AllContries": (context) => AllContries(),
      },
    );
  }
}
