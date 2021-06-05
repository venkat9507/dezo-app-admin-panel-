import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/locationmodel.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  TextEditingController locationNameController = TextEditingController();
  TextEditingController locationPinCodeController = TextEditingController();
  String locationID;
  static LocationController instance = Get.find();
  RxList<LocationModel> locations = RxList<LocationModel>([]);
  @override
  onReady() {
    super.onReady();
    locations.bindStream(getrestaurants());
  }

  Stream<List<LocationModel>> getrestaurants() =>
      firebaseFirestore.collection('dezo').snapshots().map((query) => query.docs
          .map((item) => LocationModel.fromMap(item.data()))
          .toList());


  save() async {
    locationID = locationNameController.text.substring(0,3) + locationPinCodeController.text.substring(0,3);
    print(locationID);
    if(locationNameController.text != '' &&  locationPinCodeController.text != ''){
      return
          await  FirebaseFirestore.instance.collection('dezo').doc(locationNameController.text ).set({
          'name': locationNameController.text,
          'code':locationID,
            'pinCode' :locationPinCodeController.text,
        }).then((value) {
            locationNameController.text  ='';
          locationPinCodeController.text = '';
          update();
          print('restaurant Updated');
          Get.to(OffersPage());
        });
    }
  }
}
