import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/locationmodel.dart';
import 'package:digimartadmin/screens/location_set/location_set.dart';
import 'package:digimartadmin/screens/restaurant_set/restaurants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [

              Text('Locations', style: Theme.of(context).textTheme.title),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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

                          Get.to(LocationSet());
                        },
                        icon: Icon( Icons.add),
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: locationController.locations.length,
                shrinkWrap: true,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (context, index) {
                  var data = locationController.locations[index];
                  print(data);
                  return Container(
                    color: secondaryColor,
                    child: InkWell(
                      onLongPress: (){
                        deleteLocation(data);
                      },
                      onTap: () {
                        // restaurantController.restaurants.clear();
                        restaurantController.restaurants.bindStream(
                            restaurantController.getrestaurants(data.name));
                        restaurantController.docID.value = data.name;
                        // print( restaurantController.docID.value);
                        Get.to(() => RestaurantsPage());
                      },
                      child: Card(
                        color: Colors.pink,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Center(
                            child: ListTile(

                              title: Text(data.name.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: size.height * 0.02),),
                              subtitle: Text(data.code.toUpperCase(),
                                  // overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white,fontSize: size.height * 0.01),),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                // children: restaurantController.restaurants
                //     .map(
                //       (element) => Card(
                //         color: secondaryColor,
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Card(
                //               color: bgColor,
                //               child: ListTile(
                //                 title: Text(element.name),
                //                 subtitle: Text(element.address,
                //                     overflow: TextOverflow.ellipsis,
                //                     style:
                //                         Theme.of(context).textTheme.overline),
                //               )),
                //         ),
                //       ),
                //     )
                //     .toList()
              ),
            ],
          ),
        ),
      )),
    );
  }
  deleteLocation(LocationModel locationModel){
    Get.defaultDialog(
      title: 'Warning',
      content: Column(
        children: [
          Text('Are you sure you want to  delete this Location !!'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                Get.back();
              }, child: Text('Cancel'),),
              TextButton(onPressed: (){
                locationController.delete(locationModel);
              }, child: Text('OK'),),

            ],
          )
        ],
      )
    );
  }
}
