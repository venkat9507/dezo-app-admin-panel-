import 'dart:async';
import 'dart:html';
import 'package:firebase/firebase.dart' as fb;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  static FoodController instance = Get.find();
  RxList<FoodModel> foods = RxList<FoodModel>([]);
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



  void uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
        showDialog(
            context:Get.context,
            builder: (BuildContext context) {
              return
                AlertDialog(content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularProgressIndicator(),
                      Text('Loading...')
                    ]
                ),);

            }
        );
      });
    });
  }

  void uploadToStorage({fileName}) {
    final path = '${'dezo'}items/$fileName';
    uploadImage(onSelected: (file) {
      fb
          .storage()
          .refFromURL('gs://restaurantpos-6ceb4.appspot.com/')
          .child(path)
          .put(file)
          .future
          .then((data) async {
        Uri uri = await data.ref.getDownloadURL();
        foodController.image.value = uri.toString();
        Navigator.pop(Get.context);
      });
    });
  }
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
          Future.delayed(Duration(milliseconds: 1000),(){
            Get.to(OffersPage());
          });

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

  delete(FoodModel food)async{
    // String docid = ;
    String img = image.value;
    // print(docid);
      return
        await  FirebaseFirestore.instance.collection('dezo').doc(restaurantController.docID.value).collection('restaurants').doc(docID.value).update({

          "food": FieldValue.arrayRemove([
            {
              'category': food.category,
              "count": food.count,
              "discountprice": food.discountprice,
              "featured": food.featured,
              "isdeliverable": food.isdeliverable,
              "name": food.name,
              "ondiscount": food.ondiscount,
              "photo_url": food.photourl,
              'price': food.price,
              'unit':food.unit,
              'weight': food.weight,
            }
          ])
        }).then((value) {
          Get.snackbar('deleted', 'food deleted');
          print('restaurant Updated');
          Future.delayed(Duration(milliseconds: 1000),(){
            Get.to(OffersPage());
          });

        });
  }
  edit(FoodModel food)async{
    // String docid = ;
    String img = image.value;
    // print(docid);
    return
      await  FirebaseFirestore.instance.collection('dezo').doc(restaurantController.docID.value).collection('restaurants').doc(docID.value).update({

        "food": FieldValue.arrayUnion([
          {
            'category': food.category,
            "count": food.count,
            "discountprice": food.discountprice,
            "featured": food.featured,
            "isdeliverable": food.isdeliverable,
            "name": foodNameController.text != '' ? foodNameController.text : food.name,
            "ondiscount": food.ondiscount,
            "photo_url": img == null ? food.photourl : img,
            'price': priceController.text != '' ? priceController.text : food.price,
            'unit':food.unit,
            'weight': weightController.text != '' ? weightController.text : food.weight ,
          }
        ])
      }).then((value) {
        Get.snackbar('Edited', 'food Updated');
        print('restaurant Updated');

      });
  }
}
