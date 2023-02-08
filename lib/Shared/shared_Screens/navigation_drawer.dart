import 'package:cb_stocks/controller/main_controller.dart';
import 'package:cb_stocks/screens/CBHomeScreen.dart';
import 'package:cb_stocks/screens/CBSearchScreen.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarColor: Colors.yellow,
            statusBarIconBrightness: Brightness.dark),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        )),
      ));

  Widget buildHeader(BuildContext context) => Container(
        height: 250,
        decoration: const BoxDecoration(color: Colors.yellow),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/icons/cb_stock_logo.png',
                height: 140,
                width: 140,
              ),
            ),
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Wrap(
          // runSpacing: 10,
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                MainController mc = Get.find();
                Get.to(() => const CBHomeScreen());
              },
              leading: Image.asset(
                'assets/icons/house.png',
                height: 30,
                width: 30,
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 18, color: CBColors.redCrayola),
              ),
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/request.png',
                height: 30,
                width: 30,
              ),
              title: const Text(
                'About Us',
                style: TextStyle(fontSize: 18, color: CBColors.redCrayola),
              ),
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/padlock.png',
                height: 30,
                width: 30,
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 18, color: CBColors.redCrayola),
              ),
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const CBSearchScreen()));
              },
              leading: Image.asset(
                'assets/icons/search.png',
                height: 30,
                width: 30,
              ),
              title: const Text(
                'Search',
                style: TextStyle(fontSize: 18, color: CBColors.redCrayola),
              ),
            ),
            const Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
          ],
        ),
      );
}
