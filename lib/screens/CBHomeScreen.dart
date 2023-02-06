import 'package:cached_network_image/cached_network_image.dart';
import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/Shared/shared_widget/shimmer_loading_for_category_list.dart';
import 'package:cb_stocks/Shared/shared_widget/shimmer_loading_for_color_list.dart';
import 'package:cb_stocks/Shared/shared_widget/shimmer_loading_of_best_of_wallpaper.dart';
import 'package:cb_stocks/controller/main_controller.dart';
import 'package:cb_stocks/screens/CBImageFullView.dart';
import 'package:cb_stocks/screens/CBStaggeredListView.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:cb_stocks/utils/CBStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class CBHomeScreen extends StatefulWidget {
  const CBHomeScreen({super.key});

  @override
  State<CBHomeScreen> createState() => _CBHomeScreenState();
}

class _CBHomeScreenState extends State<CBHomeScreen> {
  ScrollController scrollCtr = ScrollController();
  MainController mc = Get.put(MainController());

  List<Color> color = [
    Colors.green,
    Colors.pink,
    Colors.brown,
    Colors.deepOrange,
    Colors.blue,
    Colors.greenAccent,
    Colors.purple,
    Colors.green,
    Colors.pink,
    Colors.brown,
    Colors.deepOrange,
    Colors.blue,
    Colors.greenAccent,
    Colors.purple
  ];

  List<String> categories = [
    "Abstrack",
    "Nature",
    "Dhoom3",
    "DDLJ",
    "Besharm",
    "YJDK",
    "Welcome"
  ];

  @override
  void initState() {
    if (mc.latestImageList.isEmpty) {
      mc.fetchLatestImage();
    }
    if (mc.colorsList.isEmpty) {
      mc.fetchColorsLists();
    }

    if (mc.categoryList.isEmpty) {
      mc.fetchCategoryLoading();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.05;
    return CBBasicLayout(
        screenHeading: 'CB Stocks',
        statusColor: CBColors.white,
        hasParentPadding: false,
        child: ListView(
          controller: scrollCtr,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                'Best Of Wallpaper',
                style: CBStyles.headingTextStyle,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => mc.latestImageLoading.value
                ? const ShimmerLoadingOfBestOfWallpaper()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: ListView.builder(
                        controller: scrollCtr,
                        shrinkWrap: true,
                        itemCount: mc.latestImageList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var x = mc.latestImageList[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CBImageFullViewScreen(
                                      imageList: mc.latestImageList,
                                      index: index,
                                    ))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: index == 0 ? horizontalPadding : 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  imageUrl: x.path ?? "",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/icons/ad_banner.png'),
                                ),
                              ),
                            ),
                          );
                        }),
                  )),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                'The Color tone',
                style: CBStyles.headingTextStyle,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => mc.colorLoading.value
                ? Padding(
                    padding: EdgeInsets.only(left: horizontalPadding),
                    child: const ShimmerLoadingForColorList(),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ListView.builder(
                        controller: scrollCtr,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: horizontalPadding),
                        itemCount: mc.colorsList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var x = mc.colorsList[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: CBStaggeredListView(
                                      tagColors: x,
                                    ))),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.16,
                              margin: EdgeInsets.symmetric(
                                  horizontal: index == 0 ? 0 : 8),
                              decoration: BoxDecoration(
                                  // color: Color(int.parse('0xff${x.code}')),
                                  color: color[index],
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                        }),
                  )),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                'Categories',
                style: CBStyles.headingTextStyle,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => mc.categoryLoading.value
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: const ShimmerLoadingForCategoryList(),
                  )
                : GridView.builder(
                    itemCount: mc.categoryList.length,
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    controller: scrollCtr,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            mainAxisExtent: 100),
                    itemBuilder: (BuildContext context, int index) {
                      var x = mc.categoryList[index];
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CBStaggeredListView(
                                  category: x,
                                ))),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: index == 0 ? 0 : 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    // width:
                                    //     MediaQuery.of(context).size.width / 2.5,
                                    imageUrl: x.image ?? "",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/icons/ad_banner.png'),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                x.name ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
