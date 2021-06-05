import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../models/productmodel.dart';


class RestaurantControllers extends GetxController {
  TextEditingController restaurantNameController;
  TextEditingController deliveryBoyController;
  TextEditingController deliveryFeeController;
  TextEditingController deliveryRangeController;
  TextEditingController restaurantTaxController;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController adminCommissionController;
  RxList<RestaurantModel> restaurantList = RxList<RestaurantModel>([]);
  RxList<RestaurantModel> locationList = RxList<RestaurantModel>([]);
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String restaurantName;
  String deliveryBoyName;
  String deliveryFee;
  String deliveryRange;
  String restaurantTax;
  String phone;
  String address;
  String adminCommission;


  bool restaurantTextField=false;

  static RestaurantControllers instance;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    restaurantNameController = TextEditingController();
    deliveryBoyController = TextEditingController();
    deliveryFeeController = TextEditingController();
    deliveryRangeController = TextEditingController();
    restaurantTaxController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    adminCommissionController = TextEditingController();
  }
  @override
  onReady() {
    super.onReady();
    // products.bindStream(getAllProducts());
    restaurantList.bindStream(getAllRest());

  }
  // Stream<List<ProductModel>> getAllProducts() =>
  //     firebaseFirestore.collection("products").snapshots().map((query) {
  //
  //         query.docs.map((item) => ProductModel.fromMap(item.data())).toList();
  //      print( query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
  //         }
  //     );

  Stream<List<RestaurantModel>> getAllRest() =>
      firebaseFirestore.collection("dezo").doc('retaurant').collection('retaurant').snapshots().map((query) =>

        query.docs.map((item) => RestaurantModel.fromMap(item.data())).toList()
        // print( query.docs.map((item) => RestaurantModel.fromMap(item.data())).toList());

      );

  save()async{
    if(
    restaurantNameController.text != null && phoneController.text != null && addressController.text != null) {
      return
        await  FirebaseFirestore.instance.collection('dezo').doc('restaurant').collection('retaurant').doc(restaurantNameController.text).set({
            'retaurantName': restaurantNameController.text,
            'phone': phoneController.text,
            'address': addressController.text,
          }).then((value) {
            phone = null;
            address = null;
            restaurantName = null;
            restaurantNameController.text  ='';
            phoneController.text  ='';
            addressController.text  ='';
            update();
            print('restaurant Updated');
            Get.snackbar('Updated', 'Restaurant Updated');
          });
    }
  }

}