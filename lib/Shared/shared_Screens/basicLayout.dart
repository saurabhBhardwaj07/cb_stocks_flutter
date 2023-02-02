import 'package:cb_stocks/Shared/shared_Screens/navigation_drawer.dart';
import 'package:cb_stocks/screens/CBSearchScreen.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class CBBasicLayout extends StatelessWidget {
  final bool hasParentPadding;
  final Widget child;
  final Color statusColor;
  final String? screenHeading;
  final bool hideSideDrawer;
  final bool showAppBar;
  final bool backIcon;
  const CBBasicLayout(
      {super.key,
      this.hasParentPadding = true,
      this.showAppBar = true,
      this.hideSideDrawer = false,
      this.backIcon = false,
      required this.child,
      this.screenHeading,
      this.statusColor = CBColors.white});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.05;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CBColors.white,
        extendBody: true,
        drawer: !showAppBar ? null : const NavigationDrawer(),
        appBar: !showAppBar
            ? null
            : AppBar(
                leading: backIcon == true
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
                    : null,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: statusColor,
                    statusBarIconBrightness: Brightness.dark),
                centerTitle: true,
                backgroundColor: CBColors.white,
                elevation: 0.0,
                actions: backIcon == true
                    ? null
                    : [
                        Padding(
                          padding: EdgeInsets.only(right: horizontalPadding),
                          child: IconButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const CBSearchScreen())),
                              icon: const Icon(Icons.search)),
                        )
                      ],
                iconTheme: const IconThemeData(color: CBColors.lava, size: 30),
                title: Text(
                  screenHeading ?? "",
                  style: const TextStyle(color: CBColors.lava),
                ),
              ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: statusColor,
                statusBarIconBrightness: Brightness.dark),
            child: Container(
              width: size.width,
              height: size.height,
              padding: hasParentPadding
                  ? EdgeInsets.symmetric(horizontal: horizontalPadding)
                  : null,
              child: SafeArea(child: child),
            )));
  }
}
