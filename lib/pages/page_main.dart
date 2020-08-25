import 'package:flutter/material.dart';
import '../theme/constants.dart';
import '../pages/search.dart';

class PageMain extends StatefulWidget {
  @override
  _PageMainState createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
            IconButton(icon: Icon(Icons.search), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),));
            }),
            IconButton(icon: Icon(Icons.person), onPressed: () {})
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
