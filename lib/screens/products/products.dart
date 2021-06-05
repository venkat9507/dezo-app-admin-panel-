import 'package:digimartadmin/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String dropdownValue = 'All';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: SearchField(),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Obx(
                                () => Dialog(
                                  backgroundColor: bgColor,
                                  child: SingleChildScrollView(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Add Products',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .title,
                                            ),
                                          ),
                                          Card(
                                            color: secondaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Product Name'),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: secondaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Regular Price'),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: secondaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Product Description'),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: secondaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Product Pincode'),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: secondaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Product Stock'),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            color: secondaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    hintText: 'Offer Price'),
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
                                                    'Select your category :'),
                                                trailing: DropdownButton(
                                                  value: dropdownValue,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      this.dropdownValue =
                                                          value;
                                                    });
                                                  },
                                                  items: productsController
                                                      .categories
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('Cancel'),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primaryColor),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('Save'),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primaryColor),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text('Add Item'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                DataTable(
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
                      label: Text('Product ID'),
                    ),
                    DataColumn(
                      label: Text('Price'),
                    ),
                    DataColumn(
                      label: Text('Available Stock'),
                    ),
                    DataColumn(
                      label: Text('On sale'),
                    ),
                    DataColumn(
                      label: Text('Offer Price'),
                    ),
                    DataColumn(
                      label: Text('Description'),
                    ),
                    DataColumn(
                      label: Text('Category'),
                    ),
                    DataColumn(
                      label: Text('Actions'),
                    ),
                  ],
                  rows: productsController.products
                      .map(
                        (element) => DataRow(cells: [
                          DataCell(Text('1')),
                          DataCell(
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.network(
                                element.photo[0],
                                height: 120,
                                width: 120,
                              ),
                            ),
                          ),
                          DataCell(Text(element.name)),
                          DataCell(Text(element.productid)),
                          DataCell(Text(element.price.toString())),
                          DataCell(Text(element.quantity.toString())),
                          DataCell(Text(element.onsale.toString())),
                          DataCell(Text('65')),
                          DataCell(
                            SizedBox(
                              width: 200,
                              child: Text(
                                element.description,
                                style: TextStyle(fontSize: 12.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(element.category),
                          ),
                          DataCell(
                            Row(
                              children: [],
                            ),
                          ),
                        ]),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(16.0 * 0.75),
            margin: EdgeInsets.symmetric(horizontal: 16.0 / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
