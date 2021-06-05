import 'package:digimartadmin/constants.dart';
import 'package:digimartadmin/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/responsive.dart';
import 'card.dart';
import 'header.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        // padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: 16.0),
            Responsivecard(size: _size),
            Obx(
              () => Container(
                // height: 350,
                child: Card(
                  color: secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent Orders',
                            style: Theme.of(context).textTheme.title),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderController.orders.length,
                          itemBuilder: (context, index) {
                            String formattedDate =
                                DateFormat('EEE, d-M-y | hh:mm').format(
                                    orderController.orders[index].datetime
                                        .toDate());
                            return Card(
                                color: bgColor,
                                child: ListTile(
                                  title: Text(
                                      orderController.orders[index].cusname),
                                  subtitle: Text(formattedDate,
                                      style:
                                          Theme.of(context).textTheme.overline),
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Responsivecard extends StatelessWidget {
  const Responsivecard({
    Key key,
    @required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: FileInfoCardGridView(
        crossAxisCount: _size.width < 650 ? 2 : 4,
        childAspectRatio: _size.width < 650 ? 1.3 : 1,
      ),
      tablet: FileInfoCardGridView(),
      desktop: FileInfoCardGridView(
        childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
      ),
    );
  }
}
