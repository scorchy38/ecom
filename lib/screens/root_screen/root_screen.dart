import 'package:ecom/screens/all_categories/all_categories.dart';
import 'package:ecom/screens/home/home_screen.dart';
import 'package:ecom/screens/manage_addresses/manage_addresses_screen.dart';
import 'package:ecom/screens/my_orders/my_orders_screen.dart';
import 'package:ecom/screens/notifications_screen/notifications_screen.dart';
import 'package:ecom/screens/profile_screen/profile_screen.dart';
import 'package:ecom/screens/search_result/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../constants.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

PersistentTabController _controllerTab =
    PersistentTabController(initialIndex: 0);

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      backgroundColor: Colors.white,

      controller: _controllerTab,
      items: navBarItems,
      screens: _buildScreens(),
//      showElevation: true,
//      navBarCurve: NavBarCurve.upperCorners,
//       confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      iconSize: 26.0,
      navBarStyle:
          NavBarStyle.style5, // Choose the nav bar style with this property
      // onItemSelected: (index) {
      //   print(index);
      // },
    );
  }
}

List<PersistentBottomNavBarItem> navBarItems = [
  PersistentBottomNavBarItem(
    icon: Icon(Icons.home),
    title: ("Home"),
    activeColor: Color(0xFF449DD1),
    inactiveColor: Colors.blueGrey,
  ),
  PersistentBottomNavBarItem(
    icon: Icon(Icons.category),
    title: ("Categories"),
    activeColor: Color(0xFF76BED0),
    inactiveColor: Colors.blueGrey,
  ),
  PersistentBottomNavBarItem(
    icon: Icon(Icons.notifications),
    title: ("Notifications"),
    activeColor: Color(0xFF76BED0),
    inactiveColor: Colors.blueGrey,
  ),
  PersistentBottomNavBarItem(
    icon: Icon(Icons.person),
    title: ("Profile"),
    activeColor: Color(0xFF76BED0),
    inactiveColor: Colors.blueGrey,
  ),
];

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    AllCategories(),
    NotificationsScreen(),
    ProfileScreen(),
  ];
}
