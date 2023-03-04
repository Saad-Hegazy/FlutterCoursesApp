import 'package:flutter/material.dart';
import 'package:parmageto/theme/color.dart';
import 'package:parmageto/viwe/root_app.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primary,
      ),
      title: 'Parmageto',
      home: RootApp(),
    );}
}
