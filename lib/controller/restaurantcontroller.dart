import 'dart:html';
import 'package:firebase/firebase.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  static RestaurantController instance = Get.find();
  RxList<RestaurantModel> restaurants = RxList<RestaurantModel>([]);
  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController restaurantPhoneController = TextEditingController();
  TextEditingController restaurantAddressController = TextEditingController();
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
    String docid = docID.value;
    String img = image.value;
    print(docid);
    if(
    restaurantNameController.text != '' && restaurantPhoneController.text != '' && restaurantAddressController.text != '') {
      return
        await  FirebaseFirestore.instance.collection('dezo').doc(docid).collection('restaurants').doc(restaurantNameController.text).set({
          'name': restaurantNameController.text,
          'phone': restaurantPhoneController.text,
          'address': restaurantAddressController.text,
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
    String docid = docID.value;
    String img = image.value;
    print(docid);
    await  FirebaseFirestore.instance.collection('dezo').doc(docid).collection('restaurants').doc(element.name).update({
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
