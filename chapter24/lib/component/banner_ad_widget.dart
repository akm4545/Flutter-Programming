import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late final BannerAd banner;

  @override
  void initState() {
    super.initState();

    // 사용할 광고 ID를 설정한다
    final adUnitId = Platform.isIOS
      ? 'ca-app-pub-3940256099942544/2934735716'
      : 'ca-app-pub-3940256099942544/6300978111'
    ;

    // 광고를 생성한다
    banner = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,

      // 광고의 생명주기가 변경될 때마다 실행할 함수들을 설정한다
      listener: BannerAdListener(onAdFailedToLoad: (ad, error){
        ad.dispose();
      }),
      // 광고 요청 정보를 담고 있는 클래스
      request: AdRequest(),
    );

    // 광고를 로딩한다
    banner.load();
  }

  @override
  void dispose() {
    // 위젯이 dispose 되면 광고 또한 dispose 한다
    banner.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 광고의 높이를 지정해준다
      height: 75,
      
      // 광고 위젯에 banner 변수를 입력한다
      child: AdWidget(ad: banner),
    );
  }
}