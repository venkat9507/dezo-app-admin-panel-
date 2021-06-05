import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/screens/category/categories.dart';
import 'package:digimartadmin/screens/dashboard/widgets/dashordwidget.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:digimartadmin/screens/location_set/location_set.dart';
import 'package:digimartadmin/screens/offers/offersPage.dart';
import 'package:digimartadmin/screens/orders/ordersPage.dart';
import 'package:digimartadmin/screens/products/products.dart';
import 'package:digimartadmin/screens/restaurant_set/restaurant_adding_displaying.dart';
import 'package:digimartadmin/screens/restaurant_set/restaurants.dart';
import 'package:digimartadmin/screens/users/userspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/responsive.dart';
import 'widgets/sidemenu.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      drawer: Obx(
        () => SideMenu(),
      ),
      body: SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (Responsive.isDesktop(context))
            Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            // It takes 5/6 part of the screen
            flex: 5,
            child: PageView(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  userController.pageindex.value = value;
                },
                controller: userController.controller,
                children: [
                  // DashboardScreen(),
                  // ProductsScreen(),
                  // CategoriesPage(),
                  // OrdersPage(),
                  // OffersPage(),
                  // UsersPage(),
                  OffersPage(),
                ]),
          ),
        ]),
      ),
    );
  }
}
