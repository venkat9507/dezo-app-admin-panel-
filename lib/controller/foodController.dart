import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  static FoodController instance = Get.find();
  // RxList<RestaurantModel> restaurants = RxList<RestaurantModel>([]);
  TextEditingController foodNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  RxString image = ''.obs;
  RxString docID= ''.obs;

  // Stream<List<RestaurantModel>> getrestaurants(document) => firebaseFirestore
  //     .collection('dezo')
  //     .doc(document)
  //     .collection('restaurants')
  //     .snapshots()
  //     .map((query) => query.docs
  //     .map((item) => RestaurantModel.fromMap(item.data()))
  //     .toList());


  save()async{
    // String docid = ;
    String img = image.value;
    // print(docid);
    if(
    foodNameController.text != '' && priceController.text != '' && weightController.text != '') {
      return
        await  FirebaseFirestore.instance.collection('dezo').doc(restaurantController.docID.value).collection('restaurants').doc(docID.value).update({

          "food": FieldValue.arrayUnion([
            {
              'category': '',
              "count": '',
              "discountprice": '',
              "featured": false,
              "isdeliverable": true,
              "name": foodNameController.text,
              "ondiscount": true,
              "photo_url": img,
              'price': priceController.text,
              'unit':'',
              'weight': weightController.text,
            }
          ])
        }).then((value) {
          Get.snackbar('Updated', 'Restaurant Updated');
          foodNameController.text  ='';
          priceController.text = '';
          weightController.text = '';
          update();
          print('restaurant Updated');

          Get.to(OffersPage());
        });

    }
    else
    {
      Get.snackbar(
        'Warning',
        'Please fill All Fields ',
        backgroundColor: Color(0xFFFF0000) ,
        colorText: Color(0xFFFFFFFF),);
    }
  }

}
