import 'package:digimartadmin/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            Row(
              children: [
                Text('Categories', style: Theme.of(context).textTheme.title),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text('Add New'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: productsController.categories.length,
                itemBuilder: (context, index) {
                  var element = productsController.categories[index];
                  return Card(
                    color: secondaryColor,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(element),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                              label: Text('Edit'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class Carousals extends StatelessWidget {
  const Carousals({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Carousal', style: Theme.of(context).textTheme.title),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Add New'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 400,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: productsController.categories.length,
              itemBuilder: (context, index) {
                var element = productsController.categories[index];
                return Card(
                  color: secondaryColor,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(element),
                        Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                          label: Text('Edit'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
