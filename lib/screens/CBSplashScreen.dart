import 'dart:async';

import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/screens/CBHomeScreen.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:cb_stocks/utils/CBStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class CBSplashScreen extends StatefulWidget {
  const CBSplashScreen({super.key});

  @override
  State<CBSplashScreen> createState() => _CBSplashScreenState();
}

class _CBSplashScreenState extends State<CBSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _fabAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fabAnimation = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut)));
    _controller.forward();

    _controller.addListener(() {
      if (_controller.isCompleted) {
        Timer(const Duration(seconds: 1), () {
          navigateToNextScreen();
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: const CBHomeScreen()));
  }

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
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light),
            child: Container(
              width: size.width,
              height: size.height,
              child: SafeArea(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.yellow,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                              height: 160,
                              width: double.infinity,
                              color: Colors.pink),
                        ),
                        ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                              height: 130,
                              width: double.infinity,
                              color: Colors.red),
                        ),
                        ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                              height: 110,
                              width: double.infinity,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Spacer(),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _fabAnimation.value,
                          child: Center(
                            child: Image.asset(
                              'assets/icons/cb_stock_logo.png',
                              height: 220,
                              width: 220,
                            ),
                          ),
                        );
                      },
                    ),
                    const Spacer(
                      flex: 2,
                    )
                  ],
                ),
              )),
            )));
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10.0);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper waveClipper) {
    return waveClipper != this;
  }
}
