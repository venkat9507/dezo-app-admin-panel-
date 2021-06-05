import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSetController extends GetxController{
  static LocationSetController instance = Get.find();
  TextEditingController locationController;
  TextEditingController locationIDController;
  TextEditingController locationPinCodeController;
  RxList firebaseLocation = [].obs;
  bool locationTextField=false;
  String code;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    streamBuilder();
    locationController = TextEditingController();
    locationIDController = TextEditingController();
    locationPinCodeController = TextEditingController();
  }
  save() async{
    // code = locationController.text.substring(1,2) +
    // if(locationController.text != '' || locationIDController.text != ''){
    //   return
    //     await  FirebaseFirestore.instance.collection('dezo').doc(locationController.text).set({
    //     'name': locationController.text,
    //     'code':
    //       'pinCode' :
    //   }).then((value) {
    //     locationController.text  ='';
    //     locationIDController.text  ='';
    //     locationPinCodeController.text = '';
    //     update();
    //     print('restaurant Updated');
    //
    //   });
    // }
  }

  streamBuilder(){
    return
      StreamBuilder(
          stream:FirebaseFirestore.instance
              .collection('hospital')
              .doc('doctorDetails')
              .collection('doctorDetails')
              .doc('demo')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
            }
            else
            {
              print(snapshot.data['doctorName']);
              firebaseLocation = snapshot.data['doctorName'];
              update();
              return
                Container();
            }

          });
  }

}