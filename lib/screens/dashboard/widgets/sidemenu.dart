import 'package:digimartadmin/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                  child: Text(
                'Dezo Restaurant',
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white),
              )),
            ),
            // ListTile(
            //   onTap: () {
            //     userController.controller.jumpToPage(0);
            //   },
            //   leading: Icon(Icons.dashboard),
            //   title: Text("Dashbord"),
            // ),
            // Divider(),
            // ListTile(
            //   onTap: () {
            //     userController.controller.jumpToPage(1);
            //   },
            //   leading: Icon(Icons.shopping_bag),
            //   title: Text("Products"),
            // ),
            // Divider(),
            // ListTile(
            //   onTap: () => userController.controller.jumpToPage(2),
            //   leading: Icon(Icons.list),
            //   title: Text("Category"),
            // ),
            // Divider(),
            // ListTile(
            //   onTap: () => userController.controller.jumpToPage(3),
            //   leading: Icon(Icons.shopping_cart),
            //   title: Text("Order"),
            // ),
            // Divider(),
            // ListTile(
            //   onTap: () => userController.controller.jumpToPage(4),
            //   leading: Icon(Icons.local_offer),
            //   title: Text("Offer"),
            // ),
            // Divider(),
            // ListTile(
            //   onTap: () => userController.controller.jumpToPage(5),
            //   leading: Icon(Icons.supervisor_account),
            //   title: Text("Users"),
            // ),
            // Divider(),
            ListTile(
              onTap: () {
                userController.controller.jumpToPage(0);
              },
              leading: Icon(Icons.location_on),
              title: Text("Location"),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    @required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
