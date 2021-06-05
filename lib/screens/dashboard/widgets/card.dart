import 'package:digimartadmin/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class FileInfoCardGridView extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  FileInfoCardGridView({
    Key key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: childAspectRatio,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Card(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Product',
                        style: Theme.of(context).textTheme.title),
                    Row(
                      children: [
                        Text(productsController.products.length.toString(),
                            style: Theme.of(context).textTheme.title),
                        // Image.asset('assets/icons/shopping_bag.png')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Categories',
                        style: Theme.of(context).textTheme.title),
                    Row(
                      children: [
                        Text(productsController.categories.length.toString(),
                            style: Theme.of(context).textTheme.title),
                        // Image.asset('assets/icons/shopping_bag.png')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Oders',
                        style: Theme.of(context).textTheme.title),
                    Row(
                      children: [
                        Text(orderController.orders.length.toString(),
                            style: Theme.of(context).textTheme.title),
                        // Image.asset('assets/icons/shopping_bag.png')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            color: secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Total Users',
                        style: Theme.of(context).textTheme.title),
                    Row(
                      children: [
                        Text(userController.users.length.toString(),
                            style: Theme.of(context).textTheme.title),
                        // Image.asset('assets/icons/shopping_bag.png')
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
