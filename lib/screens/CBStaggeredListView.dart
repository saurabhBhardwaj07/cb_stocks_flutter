import 'package:cached_network_image/cached_network_image.dart';
import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/Shared/shared_widget/shimmer_loading_for_staggered.dart';
import 'package:cb_stocks/Shared/shared_widget/skeleton_container.dart';
import 'package:cb_stocks/controller/staggered_image_controller.dart';
import 'package:cb_stocks/data/model/images_response.dart';
import 'package:cb_stocks/screens/CBImageFullView.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class CBStaggeredListView extends StatefulWidget {
  final Category? category;
  final TagColors? tagColors;
  const CBStaggeredListView({super.key, this.category, this.tagColors});

  @override
  State<CBStaggeredListView> createState() => _CBStaggeredListViewState();
}

class _CBStaggeredListViewState extends State<CBStaggeredListView> {
  StaggeredImageController sic = Get.put(StaggeredImageController());
  int pageNo = 1;
  final controller = ScrollController();

  @override
  void initState() {
    if (widget.category != null) {
      sic.generalFetching(widget.category?.id ?? "");
    } else {
      sic.generalFetchColorImage(widget.tagColors?.id ?? "");
    }

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (sic.hasMore.value == false) {
          pageNo = 1;
          setState(() {});
        } else {
          setState(() {
            pageNo++;
          });
          widget.category != null
              ? sic.fetchStaggeredImage(widget.category?.id ?? "",
                  pageNo: pageNo)
              : sic.fetchFetchColorImage(widget.tagColors?.id ?? "",
                  pageNo: pageNo);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int extraShimmered() {
      int rValue = 0;
      if (sic.staggeredImageList.length % 2 == 0) {
        if (sic.hasMore.value == false) {
          rValue = 1;
        } else {
          rValue = 2;
        }
      } else {
        if (sic.hasMore.value == false) {
          rValue = 1;
        } else {
          rValue = 3;
        }
      }

      return rValue;
    }

    return CBBasicLayout(
        backIcon: true,
        child: Obx(() => sic.staggeredImageLoading.value
            ? const ShimmerLoadingForStaggered()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   widget.category != null
                  //       ? widget.category?.name ?? ""
                  //       : 'Color ${widget.tagColors?.name ?? ""}',
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w700,
                  //       color: CBColors.redCrayola),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Expanded(
                    child: GridView.custom(
                      controller: controller,
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
                          (context, index) {
                        if (index < sic.staggeredImageList.length) {
                          var x = sic.staggeredImageList[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CBImageFullViewScreen(
                                      imageList: sic.staggeredImageList,
                                      index: index,
                                    ))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                width: MediaQuery.of(context).size.width / 2.5,
                                imageUrl: x.path ?? "",
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/icons/ad_banner.png'),
                              ),
                            ),
                          );
                        } else {
                          return Obx(() => sic.hasMore.value == false
                              ? Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    'Sit tight, We will add more images for you \n😎😎',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              : const SkeletonContainer.rounded());
                        }
                      },
                          childCount:
                              sic.staggeredImageList.length + extraShimmered()),
                    ),
                  ),

                  // Obx(() => sic.hasMore.value == false
                  //     ? Padding(
                  //       padding: EdgeInsets.symmetric( vertical: 20),
                  //       child: Center(
                  //           child: Text(
                  //             "Sorry We Are Running Out Of Stocks",
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(color: Colors.red),
                  //           ),
                  //         ),
                  //     )
                  //     : SizedBox()),

                  SizedBox(
                    height: 10,
                  )
                ],
              )));
  }
}
