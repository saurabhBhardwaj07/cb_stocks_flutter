import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  const SkeletonContainer._({
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key? key,
  }) : super(key: key);
  const SkeletonContainer.square({
    double? width,
    double? height,
  }) : this._(width: width, height: height);
  const SkeletonContainer.rounded({
    double? width,
    double? height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  const SkeletonContainer.circular({
    double? width,
    double? height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(80)),
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        curve: Curves.easeInQuad,
        shimmerColor: CBColors.beauBlue,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: CBColors.beauBlue,
            borderRadius: borderRadius,
          ),
        ),
      );
}
