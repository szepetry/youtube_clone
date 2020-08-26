import 'package:flutter/material.dart';
import 'pages/page_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Youtube Clone",
      theme: ThemeData.dark(),
      // home: PageMain(),
      initialRoute: "/",
      routes: {
        '/page_main': (context) => PageMain(),
        '/': (context) => AuthScreen()
      },
    );
  }
}