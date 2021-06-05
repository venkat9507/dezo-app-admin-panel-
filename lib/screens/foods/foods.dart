import 'package:digimartadmin/constants/controllers.dart';
import 'package:digimartadmin/models/restaurantmodel.dart';
import 'package:digimartadmin/screens/foods/foodAdding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class FoodsPage extends StatefulWidget {
  const FoodsPage({Key key, this.foodModel}) : super(key: key);
  final List<FoodModel> foodModel;
  @override
  _FoodsPageState createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
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
                  Get.to(FoodAdding());
                },
                icon: Icon( Icons.add),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(child:Center(
    child: Obx(
      ()=> Column(
      children: [
      Text(foodController.docID.value, style: Theme.of(context).textTheme.title),
      Column(
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
        label: Text('Food Name'),
        ),
        DataColumn(
        label: Text('Price'),
        ),
        DataColumn(
        label: Text('Quantity'),
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
        rows: widget.foodModel.asMap().map(
              (index, element) => MapEntry(index, DataRow(
                  // onSelectChanged: (value){
                  //
                  // },
                  cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(IconButton(onPressed: (){
                      foodController.foods.value = widget.foodModel;
                      foodController.alertDialog();
                    },icon: Icon(Icons.edit),)),
                    DataCell(IconButton(onPressed: (){},icon: Icon(Icons.delete),)),
                    DataCell(
                      Image.network(
                        element.photourl[0]  ,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    DataCell(Text(element.name,style: TextStyle(fontSize: size.height * 0.02),)),
                    DataCell(Text(element.price)),
                    DataCell(Text(element.weight.toString())),
                  ]),)
        ).values.toList(),
        ),
      ),
      ],
      ),
      ],
      ),
    ),),
    )
    );
  }
}
