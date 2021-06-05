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


  alertDialog(){
    return
        Get.defaultDialog(
          backgroundColor: secondaryColor,
          title: 'Edit',
          content: SingleChildScrollView(
            child: Column(
              children: foods.asMap().map((index, element) => MapEntry(index, SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      color: secondaryColor,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:foodController.foodNameController ,
                          decoration: InputDecoration(
                              hintText: element.name),
                        ),
                      ),
                    ),
                    Card(
                      color: secondaryColor,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: ListTile(
                            title: Text(
                                'Select Food image :'),
                            trailing: TextButton(
                              onPressed: (){
                                uploadToStorage(fileName: foodNameController.text == '' ? 'Name' : foodNameController.text);
                              },
                              child: Text('Image'),
                            )
                        ),
                      ),
                    ),
                    // Card(
                    //   color: secondaryColor,
                    //   child: Padding(
                    //     padding:
                    //     const EdgeInsets.all(8.0),
                    //     child: TextField(
                    //       onChanged: (value){
                    //         setState(() {
                    //           locationSetController.locationSet = value;
                    //         });
                    //       },
                    //       controller:locationSetController.locationController ,
                    //       decoration: InputDecoration(
                    //           hintText: 'Delivery Boys'),
                    //     ),
                    //   ),
                    // ),
                    // Card(
                    //   color: secondaryColor,
                    //   child: Padding(
                    //     padding:
                    //     const EdgeInsets.all(8.0),
                    //     child: TextField(
                    //       onChanged: (value){
                    //         setState(() {
                    //           locationSetController.locationSet = value;
                    //         });
                    //       },
                    //       controller:locationSetController.locationController ,
                    //       decoration: InputDecoration(
                    //           hintText: 'Delivery Fee'),
                    //     ),
                    //   ),
                    // ),
                    // Card(
                    //   color: secondaryColor,
                    //   child: Padding(
                    //     padding:
                    //     const EdgeInsets.all(8.0),
                    //     child: TextField(
                    //       onChanged: (value){
                    //         setState(() {
                    //           locationSetController.locationSet = value;
                    //         });
                    //       },
                    //       controller:locationSetController.locationController ,
                    //       decoration: InputDecoration(
                    //           hintText: 'Delivery Range'),
                    //     ),
                    //   ),
                    // ),
                    // Card(
                    //   color: secondaryColor,
                    //   child: Padding(
                    //     padding:
                    //     const EdgeInsets.all(8.0),
                    //     child: TextField(
                    //       onChanged: (value){
                    //         setState(() {
                    //           locationSetController.locationSet = value;
                    //         });
                    //       },
                    //       controller:locationSetController.locationController ,
                    //       decoration: InputDecoration(
                    //           hintText: 'Tax of the restaurant'),
                    //     ),
                    //   ),
                    // ),
                    Card(
                      color: secondaryColor,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:foodController.priceController ,
                          decoration: InputDecoration(
                              hintText: element.price),
                        ),
                      ),
                    ), Card(
                      color: secondaryColor,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: TextField(
                          controller:foodController.weightController,
                          decoration: InputDecoration(
                              hintText: element.weight),
                        ),
                      ),
                    ),
                    // Card(
                    //   color: secondaryColor,
                    //   child: Padding(
                    //     padding:
                    //     const EdgeInsets.all(8.0),
                    //     child: TextField(
                    //       onChanged: (value){
                    //         setState(() {
                    //           locationSetController.locationSet = value;
                    //         });
                    //       },
                    //       controller:locationSetController.locationController ,
                    //       decoration: InputDecoration(
                    //           hintText: 'Admin Commission'),
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: (){
                        save();
                      },
                      child: Card(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Save',),
                        ),
                      ),),
                  ],
                ),
              ))).values.toList()
            ),
          )
        );
  }
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
