import 'dart:developer';

import 'package:cb_stocks/Service/admob_banner.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobController extends GetxController {
  var isHomePageBannerLoaded = false.obs;
  late BannerAd homePageBanner;
  var isGoBackBannerLoaded = false.obs;
  late InterstitialAd goBackPageBanner;

  void runHomePageBanner() async {
    homePageBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: AdMobHelper.homePageAdsBanner,
        listener: BannerAdListener(onAdLoaded: (ad) {
          log('HomePage Banner Loaded');
          isHomePageBannerLoaded.value = true;
        }, onAdClosed: (ad) {
          ad.dispose();
          log('HomePage Banner Dispose');
          isHomePageBannerLoaded.value = false;
        }, onAdFailedToLoad: (ad, err) {
          log(err.toString());
        }),
        request: const AdRequest());

    await homePageBanner.load();
  }

  void runFullPageAdBanner() async {
    await InterstitialAd.load(
        adUnitId: AdMobHelper.goBackAdsBanner,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          log('full Page Banner Loaded');
          isGoBackBannerLoaded.value = true;
          goBackPageBanner = ad;
        }, onAdFailedToLoad: (ad) {
          log(ad.toString());
        }));
  }

  var isUnderFullImageLoaded = false.obs;
  late BannerAd underFullImageBanner;

  void runUnderImageFullViewBanner() async {
    underFullImageBanner = BannerAd(
        size: AdSize.banner,
        adUnitId: AdMobHelper.underImageFullViewBanner,
        listener: BannerAdListener(onAdLoaded: (ad) {
          log('Under Full View Image Banner Loaded');
          isUnderFullImageLoaded.value = true;
        }, onAdClosed: (ad) {
          ad.dispose();
          log('HomePage Banner Dispose');
          isUnderFullImageLoaded.value = false;
        }, onAdFailedToLoad: (ad, err) {
          log(err.toString());
        }),
        request: const AdRequest());

    await underFullImageBanner.load();
  }

  late NativeAd nativeADS;
  var isNativeAdsLoading = false.obs;
  Future<void> runAdsInListingNative() async {
    nativeADS = NativeAd(
        adUnitId: AdMobHelper.adsInListingNative,
        factoryId: 'listTile',
        listener: NativeAdListener(onAdLoaded: (_) {
          log('Native Ad Banner Loaded');
          isNativeAdsLoading.value = true;
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          isNativeAdsLoading.value = false;
          log(error.toString());
        }),
        request: AdRequest());

    await nativeADS.load();
  }

  @override
  void onInit() {
    runFullPageAdBanner();
    super.onInit();
  }
}
