import 'package:flutter/material.dart';
import '../theme/constants.dart';
import '../pages/search.dart';
import '../authentication/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/account.dart';

class PageMain extends StatefulWidget {
  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  int _currentIndex = 0;
  String email, displayName, uid, photoURL;

  void getUserDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${user.uid}')
        .get()
        .then((value) {
      setState(() {
        email = value.data()['email'];
        displayName = value.data()['displayName'];
        uid = value.data()['uid'];
        photoURL = value.data()['photoURL'];
      });
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: SizedBox.shrink(child: Container()),
          automaticallyImplyLeading: false,
          backgroundColor: Color(colorBG),
          title: SizedBox(
            height: 30,
            width: 90,
            child: Image(
              image: AssetImage("assets/images/YouTube_Logo.png"),
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.cast), onPressed: () {}),
            IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(),
                      ));
                }),
            photoURL == null
                ? IconButton(icon: Icon(Icons.person), onPressed: () {})
                : InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(),));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipOval(
                          child: Image.network(
                        photoURL,
                        fit: BoxFit.fill,
                      )),
                    ),
                  )
          ],
        ),
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(colorBG),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          items: [
            bottomNavItem1,
            bottomNavItem2,
            bottomNavItem3,
            bottomNavItem4,
            bottomNavItem5,
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
