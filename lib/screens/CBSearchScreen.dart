import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cb_stocks/Service/admob_banner.dart';
import 'package:cb_stocks/Shared/shared_Screens/basicLayout.dart';
import 'package:cb_stocks/controller/admob_controller.dart';
import 'package:cb_stocks/data/model/images_response.dart';
import 'package:cb_stocks/data/repository.dart';
import 'package:cb_stocks/screens/CBImageFullView.dart';
import 'package:cb_stocks/utils/CBColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';

class CBSearchScreen extends StatefulWidget {
  const CBSearchScreen({super.key});

  @override
  State<CBSearchScreen> createState() => _CBSearchScreenState();
}

class _CBSearchScreenState extends State<CBSearchScreen> {
  TextEditingController searchCtr = TextEditingController();
  AdMobController adMob = Get.find();

  var isSearching = false.obs;
  var imageFound = false.obs;
  var imageNotFound = false.obs;
  var searchImageList = <SingleImagesItem>[].obs;

  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () {
      adMob.runFullPageAdBanner();
      runPageBanner();
    });
    super.initState();
  }

  Future<void> searchText() async {
    isSearching.value = true;
    setState(() {});
    await repository.searchImage(searchCtr.text).then((value) {
      var resp = ImagesResponse.fromJson(value.data);
      searchImageList.clear();

      if (resp.images.isNotEmpty) {
        imageFound.value = true;

        searchImageList.addAll(resp.images);
      } else {
        imageFound.value = false;
      }
    });
  }

  var isBannerLoad = false.obs;
  late BannerAd bottomBanner;

  void runPageBanner() async {
    bottomBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: AdMobHelper.underImageFullViewBanner,
        listener: BannerAdListener(onAdLoaded: (ad) {
          log('search Banner Loaded');
          isBannerLoad.value = true;
        }, onAdClosed: (ad) {
          ad.dispose();
          log('search Banner Dispose');
          isBannerLoad.value = false;
        }, onAdFailedToLoad: (ad, err) {
          log(err.toString());
        }),
        request: const AdRequest());

    await bottomBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    return CBBasicLayout(
        backIcon: true,
        screenHeading: 'Search',
        bottomNavigationBar: Obx(() => isBannerLoad.value == true
            ? Container(
                height: bottomBanner.size.height.toDouble(),
                child: AdWidget(ad: bottomBanner))
            : SizedBox()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: searchCtr,
              onChanged: (v) {
                searchText();
              },
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                filled: true,
                hintText: "Find Wallpaper",
                fillColor: Colors.white,
                suffixIcon: Icon(
                  Icons.search,
                  color: CBColors.prusianBlue,
                ),
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              onFieldSubmitted: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => isSearching.value == false
                ? const SizedBox()
                : imageFound.value == true
                    ? const SizedBox()
                    // Text(
                    //     'Suggestion Found',
                    //     textAlign: TextAlign.center,
                    //     style:
                    //         TextStyle(fontSize: 18, color: CBColors.redCrayola),
                    //   )
                    : const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'No Suggestion Found',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, color: CBColors.redCrayola),
                        ),
                      )),
            isSearching.value == true
                ? const SizedBox()
                : const Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Text(
                      'Type on top to search your Image ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
            Obx(() => Expanded(
                  child: GridView.custom(
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
                    childrenDelegate:
                        SliverChildBuilderDelegate((context, index) {
                      var x = searchImageList[index];
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: CBImageFullViewScreen(
                                  imageList: searchImageList,
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
                    }, childCount: searchImageList.length),
                  ),
                )),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
