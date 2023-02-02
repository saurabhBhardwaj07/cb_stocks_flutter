import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        )),
      );

  Widget buildHeader(BuildContext context) => Container(
        height: 200,
        decoration: const BoxDecoration(color: CBColors.seaweed),
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('CB Satus')],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: Wrap(
          // runSpacing: 10,
          children: const [
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('Home'),
            ),
            Divider(
              thickness: 2.0,
              color: CBColors.seaweed,
            ),
            ListTile(
              leading: Icon(Icons.info_rounded),
              title: Text('About Us'),
            ),
            Divider(
              thickness: 2.0,
              color: CBColors.seaweed,
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text('Privacy Policy'),
            ),
            Divider(
              thickness: 2.0,
              color: CBColors.seaweed,
            ),
            ListTile(
              leading: Icon(Icons.search_off_rounded),
              title: Text('Search'),
            ),
            Divider(
              thickness: 2.0,
              color: CBColors.seaweed,
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category'),
            ),
            Divider(
              thickness: 2.0,
              color: CBColors.seaweed,
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Color'),
            ),
            Divider(
              thickness: 2.0,
              color: CBColors.seaweed,
            ),
          ],
        ),
      );
}
