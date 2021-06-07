import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  static RestaurantController instance = Get.find();
  RxList<RestaurantModel> restaurants = RxList<RestaurantModel>([]);
  RxList<String> restaurantsPinCodes = RxList<String>([]);
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantPhoneController = TextEditingController();
  TextEditingController restaurantAddressController = TextEditingController();
  TextEditingController restaurantIDController = TextEditingController();
  TextEditingController restaurantPinCodeController = TextEditingController();
  var maskFormatter =                   [FilteringTextInputFormatter.allow(RegExp('[0-9,]')),];
  RxString image = ''.obs;
  RxString docID= ''.obs;
  
  Stream<List<RestaurantModel>> getrestaurants(document) => firebaseFirestore
      .collection('dezo')
      .doc(document)
      .collection('restaurants')
      .snapshots()
      .map((query) => query.docs
          .map((item) => RestaurantModel.fromMap(item.data()))
          .toList());


@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

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

check(){

}
  save()async{
    String docid = docID.value;
    String img = image.value;
    print(docid);
    if(
    restaurantNameController.text != '' && restaurantPhoneController.text != '' && restaurantAddressController.text != '' && restaurantPinCodeController.text != '' && restaurantIDController.text != '') {
      restaurantPinCodeController.text.split(',').forEach((element) {
        restaurantsPinCodes.add(element);
        print(restaurantsPinCodes);
      });
      return
        await  FirebaseFirestore.instance.collection('dezo').doc(docid).collection('restaurants').doc(restaurantIDController.text).set({
          'name': restaurantNameController.text,
          'phone': restaurantPhoneController.text,
          'address': restaurantAddressController.text,
          'restaurantID': restaurantIDController.text,
          'restaurantPinCodes': restaurantsPinCodes,
          'closed': false,
          'deliveryrange': '',
          'latitude':'',
          'longitude': '',
          'photo_url': img == null ? '' : img,
          'tax': '',
          'username': '',
          // "food": FieldValue.arrayUnion([
          //   {
          //     'category': '',
          //     "count": '',
          //     "discountprice": '',
          //     "featured": false,
          //     "isdeliverable": true,
          //     "name": '',
          //     "ondiscount": true,
          //     "photo_url": '',
          //     'price': '',
          //     'unit':'',
          //     'weight': '',
          //   }
          // ])
        }).then((value) async{
          restaurantNameController.text  ='';
          restaurantPhoneController.text = '';
          restaurantAddressController.text = '';
          await  FirebaseFirestore.instance.collection('dezo').doc('restaurantID').set({
                'restaurantID': FieldValue.arrayUnion(
                  [restaurantIDController.text],
                ),
              },SetOptions(merge: true));
          print('restaurant Updated');
          Get.snackbar('Updated', 'Restaurant Updated');
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


  edited(RestaurantModel element)async{
    print('elementName ${element.name}');
    print('textController ${restaurantPinCodeController.text}');
    String docid = docID.value;
    String img = image.value;
    restaurantPinCodeController.text.split(',').forEach((element) {
      restaurantsPinCodes.add(element);
      print(restaurantsPinCodes);
    },
    );
    print(docid);

    await  FirebaseFirestore.instance.collection('dezo').doc(docid).collection('restaurants').doc(element.restaurantId).update({
      'name': restaurantNameController.text == '' ? element.name : restaurantNameController.text,
      'restaurantPinCodes': restaurantPinCodeController.text == '' ? element.restaurantPin : restaurantsPinCodes,
      'restaurantID': restaurantIDController.text == '' ? element.restaurantId : restaurantIDController.text,
      'phone':  restaurantPhoneController.text == '' ? element.phone : restaurantPhoneController.text,
      'address':  restaurantAddressController.text == '' ? element.address : restaurantAddressController.text,
      // "food": FieldValue.arrayUnion([
      //   {
      //     'category': '',
      //     "count": '',
      //     "discountprice": '',
      //     "featured": false,
      //     "isdeliverable": true,
      //     "name": '',
      //     "ondiscount": true,
      //     "photo_url": '',
      //     'price': '',
      //     'unit':'',
      //     'weight': '',
      //   }
      // ])
    }).then((value) {
      restaurantNameController.text  ='';
      restaurantPhoneController.text = '';
      restaurantAddressController.text = '';
      update();
      print('restaurant Updated');
      Get.snackbar('Updated', 'Restaurant Updated');
      Future.delayed(Duration(milliseconds: 1000),(){
        Get.to(OffersPage());
      });
    });
  }


  delete(String restaurantName){
    print(foodController.docID.value);
    print(docID.value);
    var docid = docID.value;
    return
      FirebaseFirestore.instance.collection('dezo').doc(docid).collection('restaurants').doc(restaurantName).delete().then((value) {
        Get.snackbar('Deleted', 'Restaurant Deleted Successfully');
        Future.delayed(Duration(milliseconds: 1000),(){
          Get.to(OffersPage());
        });

      });
  }
  
}
