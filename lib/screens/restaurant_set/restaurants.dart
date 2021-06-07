import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:digimartadmin/screens/foods/foods.dart';
import 'package:digimartadmin/screens/restaurant_set/restaurant_adding_displaying.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class RestaurantsPage extends StatefulWidget {
  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Get.to(Restaurant());
                },
                icon: Icon(Icons.add),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Restaurants', style: Theme.of(context).textTheme.title),
            Obx(
              () => Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: size.width * 0.1,
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(
                          label: Text('SI.No'),
                        ),
                        DataColumn(
                          label: Text('Edit'),
                        ),
                        DataColumn(
                          label: Text('Delete'),
                        ),
                        DataColumn(
                          label: Text('Image'),
                        ),
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('ID'),
                        ),
                        DataColumn(
                          label: Text('Phone'),
                        ),
                        DataColumn(
                          label: Text('Address'),
                        ),
                        DataColumn(
                          label: Text('Restaurant Deliverable PinCode'),
                        ),
                        // DataColumn(
                        //   label: Text('Available Stock'),
                        // ),
                        // DataColumn(
                        //   label: Text('On sale'),
                        // ),
                        // DataColumn(
                        //   label: Text('Offer Price'),
                        // ),
                        // DataColumn(
                        //   label: Text('Description'),
                        // ),
                        // DataColumn(
                        //   label: Text('Category'),
                        // ),
                        // DataColumn(
                        //   label: Text('Actions'),
                        // ),
                      ],
                      rows: restaurantController.restaurants
                          .asMap()
                          .map((index, element) => MapEntry(
                                index,
                                DataRow(
                                    onSelectChanged: (value) {
                                      print('food model');
                                      foodController.docID.value = element.name;
                                      Get.to(FoodsPage(
                                        foodModel: element.food,
                                      ));
                                    },
                                    cells: [
                                      DataCell(
                                        Text(
                                          (index + 1).toString(),
                                        ),
                                      ),
                                      DataCell(IconButton(
                                        onPressed: () {
                                          // alertDialog(widget.foodModel[index]);
                                          alertDialog(element);
                                        },
                                        icon: Icon(Icons.edit),
                                      )),
                                      DataCell(IconButton(
                                        onPressed: () {
                                          restaurantController
                                              .delete(element.name);
                                        },
                                        icon: Icon(Icons.delete),
                                      )),
                                      DataCell(
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Image.network(
                                            element.image,
                                            height: 120,
                                            width: 120,
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(element.name )),
                                      DataCell(Text(element.restaurantId)),
                                      DataCell(Text(element.phone)),
                                      DataCell(
                                          Text(element.address.toString())),
                                      DataCell(
                                          Text(element.restaurantPin.toString().replaceAll('[', '').replaceAll(']', ''))),
                                    ]),
                              ))
                          .values
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  alertDialog(RestaurantModel element) {
    return Get.defaultDialog(
        title: 'Edit',
        content: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                color: secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: restaurantController.restaurantNameController,
                    decoration: InputDecoration(hintText: ' Restaurant Name'),
                  ),
                ),
              ),
              Card(
                color: secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: restaurantController.restaurantPinCodeController,
                    decoration: InputDecoration(hintText: ' Restaurant Pin Codes'),
                    inputFormatters: restaurantController.maskFormatter,
                  ),
                ),
              ),
              Card(
                color: secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      title: Text('Select restaurant image :'),
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            restaurantController.uploadToStorage(
                                fileName: restaurantController
                                            .restaurantNameController.text !=
                                        null
                                    ? 'restaurant Name Edited'
                                    : restaurantController
                                        .restaurantNameController.text);
                          });
                        },
                        child: Text('Image'),
                      ),),
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
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: restaurantController.restaurantPhoneController,
                    decoration: InputDecoration(hintText: 'Phone'),
                  ),
                ),
              ),
              Card(
                color: secondaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller:
                        restaurantController.restaurantAddressController,
                    decoration: InputDecoration(hintText: 'Address'),
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
                onTap: () {
                  setState(() {
                    restaurantController.edited(element);
                  });
                },
                child: Card(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Save',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
