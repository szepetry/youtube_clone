import 'package:flutter/material.dart';
import '../pages/explore.dart';
import '../pages/home.dart';
import '../pages/library.dart';
import '../pages/notifications.dart';
import '../pages/subscriptions.dart';

const colorBG = 0xFF282828;
const colorGreyShade = 0xFF8E8E8E;

var bottomNavItem1 = BottomNavigationBarItem(
  icon: Icon(
    Icons.home,
  ),
  title: Text(
    "Home",
  ),
);

var bottomNavItem2 = BottomNavigationBarItem(
    icon: Icon(
      Icons.explore,
    ),
    title: Text(
      "Explore",
    ));

var bottomNavItem3 = BottomNavigationBarItem(
    icon: Icon(
      Icons.subscriptions,
    ),
    title: Text(
      "Subscription",
    ));

var bottomNavItem4 = BottomNavigationBarItem(
    icon: Icon(
      Icons.notifications,
    ),
    title: Text(
      "Notifications",
    ));

var bottomNavItem5 = BottomNavigationBarItem(
    icon: Icon(
      Icons.video_library,
    ),
    title: Text(
      "Library",
    ));

final tabs = [Home(), Explore(), Subscriptions(), Notifications(), Library()];
