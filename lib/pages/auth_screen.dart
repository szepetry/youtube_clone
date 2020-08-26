import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../authentication/auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: SizedBox(
                child: Image(
              image: AssetImage("assets/images/yt_icon_rgb.png"),
              width: 100,
              height: 600,
            )),
          ),
          // Spacer(flex: 1,),
          // SizedBox(),
          Text(
            "Sign in to continue.",
            style: TextStyle(fontSize: 15),
          ),
          SignInButton(
            Buttons.GoogleDark,
            onPressed: () async {
              await Firebase.initializeApp().then((value) async {
                await AuthService().googleSignIn().then((value) {
                  if (!value)
                    debugPrint("Error logging in with Google");
                  else {
                    Navigator.pushReplacementNamed(context, '/page_main');
                  }
                });
              });
            },
          )
        ],
      ),
    );
  }
}
