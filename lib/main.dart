import 'package:flutter/material.dart';
import 'pages/page_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Youtube Clone",
      theme: ThemeData.dark(),
      home: PageMain(),
    );
  }
}