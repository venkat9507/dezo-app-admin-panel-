import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:flutter/cupertino.dart';
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
