import 'dart:io';

import 'package:cb_stocks/Shared/shared_Screens/navigation_drawer.dart';
import 'package:cb_stocks/screens/CBSearchScreen.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class CBBasicLayout extends StatefulWidget {
  final bool hasParentPadding;
  final Widget child;
  Color statusColor;
  final String? screenHeading;
  final bool hideSideDrawer;
  final bool showAppBar;
  final bool backIcon;
  CBBasicLayout(
      {super.key,
      this.hasParentPadding = true,
      this.showAppBar = true,
      this.hideSideDrawer = false,
      this.backIcon = false,
      required this.child,
      this.screenHeading,
      this.statusColor = CBColors.white});

  @override
  State<CBBasicLayout> createState() => _CBBasicLayoutState();
}

class _CBBasicLayoutState extends State<CBBasicLayout> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.05;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CBColors.white,
        extendBody: true,
        drawer: !widget.showAppBar ? null : const NavigationDrawer(),
        appBar: !widget.showAppBar
            ? null
            : AppBar(
                leading: widget.backIcon == true
                    ? Padding(
                        padding: EdgeInsets.only(left: horizontalPadding),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    : Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: IconButton(
                            icon: Image.asset('assets/icons/app-drawer.png'),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        );
                      }),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: widget.statusColor,
                    statusBarIconBrightness: Brightness.dark),
                centerTitle: true,
                backgroundColor: CBColors.white,
                elevation: 0.0,
                actions: widget.backIcon == true
                    ? null
                    : [
                        Padding(
                          padding:
                              EdgeInsets.only(right: horizontalPadding + 10),
                          child: IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const CBSearchScreen())),
                            icon: Image.asset(
                              'assets/icons/search.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        )
                      ],
                iconTheme: const IconThemeData(color: Colors.black, size: 30),
                title: Image.asset(
                  'assets/icons/cb_stock_home.png',
                  height: 40,
                )

                //  Text(
                //   screenHeading ?? "",
                //   style: const TextStyle(color: CBColors.lava),
                // ),
                ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: widget.statusColor,
                statusBarIconBrightness: Brightness.dark),
            child: Container(
              width: size.width,
              height: size.height,
              padding: widget.hasParentPadding
                  ? EdgeInsets.symmetric(horizontal: horizontalPadding)
                  : null,
              child: SafeArea(child: widget.child),
            )));
  }
}
