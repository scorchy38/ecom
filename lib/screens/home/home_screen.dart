import 'package:ecom/constants.dart';
import 'package:ecom/screens/manage_addresses/manage_addresses_screen.dart';
import 'package:ecom/screens/my_orders/my_orders_screen.dart';
import 'package:ecom/screens/search_result/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../size_config.dart';
import 'components/body.dart';
import 'components/home_screen_drawer.dart';

PersistentTabController _controllerTab =
    PersistentTabController(initialIndex: 0);

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      drawer: HomeScreenDrawer(),
    );
  }
}
