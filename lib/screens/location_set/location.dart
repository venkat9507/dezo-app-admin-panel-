import 'package:digimartadmin/constants/controllers.dart';
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
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  var data = locationController.locations[index];
                  print(data);
                  return Container(
                    color: secondaryColor,
                    child: InkWell(
                      onTap: () {
                        // restaurantController.restaurants.clear();
                        restaurantController.restaurants.bindStream(
                            restaurantController.getrestaurants(data.name));
                        restaurantController.docID.value = data.name;
                        print( restaurantController.docID.value);
                        Get.to(() => RestaurantsPage());
                      },
                      child: Card(
                        color: bgColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Center(
                            child: ListTile(

                              title: Text(data.name.toUpperCase()),
                              subtitle: Text(data.code.toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.overline),
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
}
