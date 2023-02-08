import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cb_stocks/Service/admob_banner.dart';
import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/Shared/shared_widget/custom_button.dart';
import 'package:cb_stocks/Shared/shared_widget/shimmer_loading_for_staggered.dart';
import 'package:cb_stocks/controller/admob_controller.dart';
import 'package:cb_stocks/data/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipe_to/swipe_to.dart';

import '../data/model/images_response.dart';

class CBImageFullViewScreen extends StatefulWidget {
  List<SingleImagesItem> imageList;
  int index;

  CBImageFullViewScreen(
      {super.key, required this.imageList, required this.index});

  @override
  State<CBImageFullViewScreen> createState() => _CBImageFullViewScreenState();
}

class _CBImageFullViewScreenState extends State<CBImageFullViewScreen> {
  final controller = ScrollController();
  AdMobController adMob = Get.find();
  @override
  void initState() {
    imageLiked.value = widget.imageList[widget.index].isLiked;
    fetchStaggeredImage(widget.imageList[widget.index].category?.id ?? "");
    Timer(const Duration(milliseconds: 1500), () {
      adMob.runFullPageAdBanner();
      runPageBanner();
    });
    super.initState();
  }

  var similarImageList = <SingleImagesItem>[].obs;
  var similarLoading = false.obs;
  Future<void> fetchStaggeredImage(String categoryId) async {
    similarLoading.value = true;
    repository.fetchImageByCategory(categoryId).then((value) {
      var resp = ImagesResponse.fromJson(value.data);
      similarImageList.clear();
      if (resp.images.isNotEmpty) {
        similarImageList.addAll(resp.images);
      }
    }).whenComplete(() => similarLoading.value = false);
  }

  var imageLiked = false.obs;

  var isBannerLoad = false.obs;
  late BannerAd bottomBanner;

  void runPageBanner() async {
    bottomBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: AdMobHelper.imageFullViewBottomBanner,
        listener: BannerAdListener(onAdLoaded: (ad) {
          log('HomePage Banner Loaded');
          isBannerLoad.value = true;
        }, onAdClosed: (ad) {
          ad.dispose();
          log('HomePage Banner Dispose');
          isBannerLoad.value = false;
        }, onAdFailedToLoad: (ad, err) {
          log(err.toString());
        }),
        request: const AdRequest());

    await bottomBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    adMob.runUnderImageFullViewBanner();
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.02;
    return CBBasicLayout(
      backIcon: true,
      hasParentPadding: false,
      bottomNavigationBar: Obx(() => isBannerLoad.value == true
          ? Container(
              height: bottomBanner.size.height.toDouble(),
              child: AdWidget(ad: bottomBanner))
          : SizedBox()),
      child: ListView(
        controller: controller,
        shrinkWrap: true,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height / 1.5,
            child: Stack(
              children: [
                Positioned(
                  child: SwipeTo(
                    offsetDx: 0.1,
                    iconOnRightSwipe: Icons.arrow_back_ios,
                    iconOnLeftSwipe: Icons.arrow_forward_ios,
                    onRightSwipe: () {
                      if (widget.index > 0) {
                        widget.index--;
                        imageLiked.value =
                            widget.imageList[widget.index].isLiked;
                        setState(() {});
                      }
                    },
                    onLeftSwipe: () {
                      print(widget.index);
                      print(widget.imageList.length);
                      if (widget.index < widget.imageList.length - 1) {
                        widget.index++;
                        imageLiked.value =
                            widget.imageList[widget.index].isLiked;
                        setState(() {});
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.imageList[widget.index].path ?? "",
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.medium,
                      placeholder: (context, url) {
                        return const SizedBox(
                          height: 200,
                          width: double.infinity,
                        );
                      },
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/icons/ad_banner.png'),
                    ),
                  ),
                ),
                // widget.index == 0
                //     ? const SizedBox(
                //         width: 20,
                //       )
                //     : Positioned(
                //         top: 150,
                //         left: 5,
                //         child: InkWell(
                //             onTap: () {
                //               if (widget.index > 0) {
                //                 widget.index--;
                //                 imageLiked.value =
                //                     widget.imageList[widget.index].isLiked;
                //                 setState(() {});
                //               }
                //             },
                //             child: Image.asset(
                //               'assets/icons/left-arrow.png',
                //               height: 25,
                //               color: Colors.white.withOpacity(0.7),
                //               width: 25,
                //             )),
                //       ),
                // widget.index < widget.imageList.length - 1
                //     ? Positioned(
                //         right: 5,
                //         top: 150,
                //         child: InkWell(
                //             onTap: () {
                //               print(widget.index);
                //               print(widget.imageList.length);
                //               if (widget.index < widget.imageList.length - 1) {
                //                 widget.index++;
                //                 imageLiked.value =
                //                     widget.imageList[widget.index].isLiked;
                //                 setState(() {});
                //               }
                //             },
                //             child: RotatedBox(
                //               quarterTurns: 2,
                //               child: Image.asset(
                //                 'assets/icons/left-arrow.png',
                //                 height: 25,
                //                 color: Colors.white.withOpacity(0.7),
                //                 width: 25,
                //               ),
                //             )),
                //       )
                //     : const SizedBox(
                //         width: 20,
                //       ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => adMob.isUnderFullImageLoaded.value == true
              ? SizedBox(
                  height: adMob.underFullImageBanner.size.height.toDouble(),
                  child: AdWidget(ad: adMob.underFullImageBanner),
                )
              : const SizedBox()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      height: 50,
                      title: "Like",
                      count: widget.imageList[widget.index].likes.toString(),
                      bgColor: imageLiked.value == true
                          ? Colors.pink
                          : const Color(0xFF22c35e),
                      iconColor: Colors.white,
                      onPressed: () async {
                        if (imageLiked.value == true) {
                          imageLiked.value = !imageLiked.value;
                          widget.imageList[widget.index].likes--;
                          widget.imageList[widget.index].isLiked =
                              imageLiked.value;
                          setState(() {});
                        } else {
                          imageLiked.value = !imageLiked.value;
                          widget.imageList[widget.index].likes++;
                          widget.imageList[widget.index].isLiked =
                              imageLiked.value;
                          setState(() {});
                        }

                        await repository
                            .likeImage(
                                widget.imageList[widget.index].id.toString())
                            .then((value) {});
                      },
                      icon: imageLiked.value == true
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CustomButton(
                            icon: Icons.upload,
                            bgColor: const Color(0xFFDD6B20),
                            height: 50,
                            title: "Download",
                            onPressed: () {})),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Obx(() => similarLoading.isTrue
                  ? ShimmerLoadingForStaggered(
                      controller: controller,
                    )
                  : GridView.custom(
                      shrinkWrap: true,
                      controller: controller,
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverWovenGridDelegate.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        pattern: [
                          const WovenGridTile(
                            1,
                          ),
                          const WovenGridTile(
                            5.5 / 6,
                            crossAxisRatio: 0.97,
                            alignment: AlignmentDirectional.centerEnd,
                          ),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) {
                          var x = similarImageList[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CBImageFullViewScreen(
                                      imageList: similarImageList,
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
                        },
                        childCount: similarImageList.length,
                      )))),
        ],
      ),
    );
  }
}
