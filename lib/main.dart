import 'package:digimartadmin/controller/locationcontroller.dart';
import 'package:digimartadmin/controller/restaurantcontroller.dart';
import 'package:digimartadmin/controller/usercntroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';
import 'constants/constants.dart';
import 'controller/foodController.dart';
import 'controller/ordercontroller.dart';
import 'controller/productcontroller.dart';
import 'screens/dashboard/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(UserController());
    Get.put(OrderController());
    Get.put(ProducsController());
    Get.put(LocationController());
    Get.put(RestaurantController());
    Get.put(FoodController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Digimart Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MyHomePage(),
    );
  }
}
