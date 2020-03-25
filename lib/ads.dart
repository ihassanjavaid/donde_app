
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String adDevice = "ca-app-pub-5777492202424173~3025761937";
const String interstitialID = "ca-app-pub-5777492202424173/6773435257";
const String bannerID = "ca-app-pub-5777492202424173/7164317495";

class Ads extends StatefulWidget {
  @override
  _AdsState createState() => _AdsState();
}

class _AdsState extends State<Ads> {

  static const List<String> keywordsList = ["Restaurants", "Hotels",
    "Cafe", "Lunch", "Dinner", "Restaurant", "Donde", "Eat"];

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: adDevice != null ? <String>[adDevice] : null,
      nonPersonalizedAds: false,
      keywords: keywordsList
  );


/* There are 2 types of ads:
  1. Banner Ads
  2. Interstitial Ad
  3. Rewarded Ad*/

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd(){
    return BannerAd(
        adUnitId: bannerID,
        size: AdSize.banner, // can be diff sized
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        }
    );
  }

  InterstitialAd createInterstitialAd(){
    return InterstitialAd(
        adUnitId: interstitialID,
        //size: AdSize.banner, // size not needed in this type
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd $event");
        }
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(
      appId: BannerAd.testAdUnitId
    );
    _bannerAd = createBannerAd()..load()..show();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('click for ad'),
          onPressed: () {
            _interstitialAd = createInterstitialAd()..load()..show();
          },
        ),
      ),
    );
  }
}

