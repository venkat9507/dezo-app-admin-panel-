import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartadmin/constants/constants.dart';
import 'package:digimartadmin/controller/location_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';
import '../../constants/controllers.dart';

class LocationSet extends StatefulWidget {
  const LocationSet({Key key}) : super(key: key);

  @override
  _LocationSetState createState() => _LocationSetState();
}

class _LocationSetState extends State<LocationSet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text('Location'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Card(
                  color: secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller:locationController.locationNameController ,
                      decoration: InputDecoration(hintText: ' Location'),
                    ),
                  ),
                ),
                Card(
                  color: secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller:locationController.locationPinCodeController ,
                      decoration:
                          InputDecoration(hintText: ' Location PinCode'),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      locationController.save();
                    });
                  },
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Add Location'),
                    ),
                  ),
                ),
              ],
            ),
            //  InkWell(
            //   onTap: (){
            //    setState(() {
            //    // locationSetController.save();
            //    });
            //   },
            //   child: Card(
            //      color: Colors.blue,
            //      child: Padding(
            //        padding: const EdgeInsets.all(8.0),
            //        child: Text('Save',),
            //      ),
            //    ),
            // ),
          ],
        ),
      )),
    );
  }
}
