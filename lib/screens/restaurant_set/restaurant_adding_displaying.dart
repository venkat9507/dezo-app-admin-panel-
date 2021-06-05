import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/screens/location_set/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase/firebase.dart' as fb;
import '../../constants.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({Key key}) : super(key: key);

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  List<DataRow> dataRows = [];
  List location = ['demo','All','chcek'];
  String dropdownValue = 'All';
  String image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
        children: [

          Card(
            color: secondaryColor,
            child: Padding(
              padding:
              const EdgeInsets.all(8.0),
              child: TextField(
                controller:restaurantController.restaurantNameController ,
                decoration: InputDecoration(
                    hintText: ' Restaurant Name'),
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
                    'Select restaurant image :'),
                trailing: TextButton(
                  onPressed: (){
                    setState(() {
                     uploadToStorage(fileName: restaurantController.restaurantNameController.text == '' ? 'Name' : restaurantController.restaurantNameController.text);
                    });
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
                controller:restaurantController.restaurantPhoneController ,
                decoration: InputDecoration(
                    hintText: 'Phone'),
              ),
            ),
          ), Card(
            color: secondaryColor,
            child: Padding(
              padding:
              const EdgeInsets.all(8.0),
              child: TextField(
                controller:restaurantController.restaurantAddressController,
                decoration: InputDecoration(
                    hintText: 'Address'),
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
              setState(() {
                restaurantController.save();
              });
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
      )),
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
            context:context,
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
        restaurantController.image.value = uri.toString();
        Navigator.pop(context);
      });
    });
  }
}
