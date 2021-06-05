import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase/firebase.dart' as fb;
import '../../constants.dart';
import '../../constants/controllers.dart';

class FoodAdding extends StatefulWidget {
  const FoodAdding({Key key}) : super(key: key);

  @override
  _FoodAddingState createState() => _FoodAddingState();
}

class _FoodAddingState extends State<FoodAdding> {
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
                  controller:foodController.foodNameController ,
                  decoration: InputDecoration(
                      hintText: ' Food Name'),
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
                  controller:foodController.priceController ,
                  decoration: InputDecoration(
                      hintText: 'Price'),
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
                      hintText: 'Weight'),
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
                  foodController.save();
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
        foodController.image.value = uri.toString();
        Navigator.pop(context);
      });
    });
  }
}
