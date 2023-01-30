import 'dart:async';

import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/screens/CBHomeScreen.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:cb_stocks/utils/CBStyles.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CBSplashScreen extends StatefulWidget {
  const CBSplashScreen({super.key});

  @override
  State<CBSplashScreen> createState() => _CBSplashScreenState();
}

class _CBSplashScreenState extends State<CBSplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      navigateToNextScreen();
    });

    super.initState();
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: const CBHomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return CBBasicLayout(
        hasParentPadding: false,
        statusColor: CBColors.beauBlue,
        child: Container(
          color: CBColors.beauBlue,
          child: Center(
            child: Text(
              "CB Status",
              style: CBStyles.semiBold600()
                  .copyWith(fontSize: 32, color: CBColors.redCrayola),
            ),
          ),
        ));
  }
}
