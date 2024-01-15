import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;

/// Utility class that manages loading and showing app open ads.
class AppOpenAdManager {
  /// Maximum duration allowed between loading and showing the ad.
  final Duration maxCacheDuration = const Duration(hours: 4);

  /// Keep track of load time so we don't show an expired ad.
  DateTime? _appOpenLoadTime;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  //id de teste do google:  ca-app-pub-3940256099942544/9257395921

  String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7817396682541033/4923297223'
      //? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-7817396682541033/2251959908';

  /// Load an [AppOpenAd].
  void loadAd() {
    Future.delayed(Duration.zero, () async {
      await AppOpenAd.load(
          adUnitId: adUnitId,
          request: const AdRequest(),
          adLoadCallback: AppOpenAdLoadCallback(
              onAdFailedToLoad: (error) => debugPrint('$error'),
              onAdLoaded: (ad) => ad.show()),
          orientation: AppOpenAd.orientationPortrait);
    });
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Shows the ad, if one exists and is not already being shown.
  ///
  /// If the previously cached ad has expired, this just loads and caches a
  /// new ad.
  void showAdIfAvailable() {
    if (!isAdAvailable) {
      debugPrint('Tried to show ad before available.');
      loadAd();
      return;
    }
    if (_isShowingAd) {
      debugPrint('Tried to show ad while already showing an ad.');
      return;
    }
    if (DateTime.now().subtract(maxCacheDuration).isAfter(_appOpenLoadTime!)) {
      debugPrint('Maximum cache duration exceeded. Loading another ad.');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        debugPrint('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        debugPrint('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}
