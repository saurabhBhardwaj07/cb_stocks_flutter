import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CBBasicLayout extends StatelessWidget {
  final bool hasParentPadding;
  final Widget child;
  final Color statusColor;
  const CBBasicLayout(
      {super.key,
      this.hasParentPadding = true,
      required this.child,
      this.statusColor = CBColors.white});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.05;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CBColors.white,
        extendBody: true,
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
