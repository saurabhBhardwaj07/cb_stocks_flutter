import 'package:cb_stocks/Shared/shared_widget/skeleton_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShimmerLoadingForStaggered extends StatelessWidget {
  final int count;
  const ShimmerLoadingForStaggered({super.key, this.count = 4});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        pattern: [
          const WovenGridTile(
            1,
          ),
          const WovenGridTile(
            5.1 / 6,
            crossAxisRatio: 0.94,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => const SkeletonContainer.rounded(),
          childCount: count),
    );
  }
}
