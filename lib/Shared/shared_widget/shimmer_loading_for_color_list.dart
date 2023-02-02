import 'package:cb_stocks/Shared/shared_widget/skeleton_container.dart';
import 'package:flutter/cupertino.dart';

class ShimmerLoadingForColorList extends StatelessWidget {
  const ShimmerLoadingForColorList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 8.0),
                child: SkeletonContainer.rounded(
                  width: MediaQuery.of(context).size.width * 0.14,
                ),
              );
            }));
  }
}
