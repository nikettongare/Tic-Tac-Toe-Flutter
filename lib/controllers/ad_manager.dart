import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsController extends GetxController {
  AdRequest request = const AdRequest(
    keywords: <String>[
      'foo',
      'bar',
      'wallpaper',
      'food',
      'gym',
      'hacking',
      'wordlist',
      'password',
      'generator',
      'movie',
      'youtube',
      'recipe',
      'news',
      'sale',
      'amazon',
      'flipkart',
      'games',
      'zomato',
      'swiggi',
      'google',
      'facebook',
      'microsoft',
      'ubisoft',
      'tiktok',
      'instagram',
      "bunny",
      "tacocat",
      "business"
    ],
    contentUrl: 'URL',
    nonPersonalizedAds: true,
  );

  late AdWidget adWidget;
  late BannerAd myBanner;
  late AdWidget adWidget0;
  late BannerAd myBanner0;

  String testDevice = '398CA3A0982891A5BFDADDCB1508E1C4';

  @override
  void onInit() {
    myBanner = BannerAd(
      adUnitId: "ca-app-pub-3166882328175414/4408596871",
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {},
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    myBanner0 = BannerAd(
      adUnitId: "ca-app-pub-3166882328175414/2434838525",
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {},
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    adWidget = AdWidget(ad: myBanner);
    myBanner.load();
    adWidget0 = AdWidget(ad: myBanner0);
    myBanner0.load();
    createRewardedAd();
    createInterstitialAd();
    super.onInit();
  }

  InterstitialAd? _interstitialAd;

  void createInterstitialAd() {
    try {
      InterstitialAd.load(
          adUnitId: "ca-app-pub-3166882328175414/9243789455",
          request: request,
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              _interstitialAd = ad;
              _interstitialAd!.setImmersiveMode(true);
            },
            onAdFailedToLoad: (LoadAdError error) {
              _interstitialAd = null;
              createRewardedAd();
            },
          ));
    } catch (e) {
      log(e.toString());
    }
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      createInterstitialAd();
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  RewardedAd? _rewardedAd;
  void createRewardedAd() {
    try {
      RewardedAd.load(
          adUnitId: "ca-app-pub-3166882328175414/4294715101",
          request: request,
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (RewardedAd ad) {
              _rewardedAd = ad;
            },
            onAdFailedToLoad: (LoadAdError error) {
              _rewardedAd = null;
              createRewardedAd();
            },
          ));
    } catch (e) {
      log(e.toString());
    }
  }

  void showRewardedAd({required VoidCallback onRewarded}) {
    try {
      if (_rewardedAd == null) {
        createRewardedAd();
        return;
      }
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {},
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          createRewardedAd();
        },
      );
      _rewardedAd!.setImmersiveMode(true);
      _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
        ad.dispose();
        createRewardedAd();
        onRewarded();
      });

      _rewardedAd = null;
    } catch (e) {
      log(e.toString());
    }
  }
}
