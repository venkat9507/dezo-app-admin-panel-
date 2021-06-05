import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/screens/foods/foods.dart';
import 'package:digimartadmin/screens/restaurant_set/restaurant_adding_displaying.dart';
import 'package:flutter/material.dart';
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
                    offset: Offset(2.0,
                        2.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: IconButton(
                onPressed: (){
                  Get.to(Restaurant());
                },
                icon: Icon( Icons.add),
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
                  SingleChildScrollView(scrollDirection:Axis.horizontal,
                    child: DataTable(
                      columnSpacing: size.width * 0.2,
                      showCheckboxColumn: false,
                      columns: [
                        DataColumn(
                          label: Text('SI.No'),
                        ),
                        DataColumn(
                          label: Text('Image'),
                        ),
                        DataColumn(
                          label: Text('Name'),
                        ),
                        DataColumn(
                          label: Text('Phone'),
                        ),
                        DataColumn(
                          label: Text('Address'),
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
                          .asMap().map(
                            (index, element) => MapEntry(index,DataRow(
                              onSelectChanged: (value){
                                print('food model');
                                foodController.docID.value = element.name;
                                Get.to(FoodsPage(foodModel: element.food,));
                              },
                                cells: [
                          DataCell(Text((index+1).toString(),),),
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
                          DataCell(Text(element.name)),
                          DataCell(Text(element.phone)),
                          DataCell(Text(element.address.toString())),
                        ]),)
                      ).values.toList(),

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
}
