import 'package:cb_stocks/Shared/shared_widget/skeleton_container.dart';
import 'package:flutter/material.dart';

class ShimmerLoadingForCategoryList extends StatelessWidget {
  const ShimmerLoadingForCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 100),
        itemBuilder: (context, index) {
          return const SkeletonContainer.rounded(
              // width: MediaQuery.of(context).size.width * 0.14,
              );
        });
  }
}
