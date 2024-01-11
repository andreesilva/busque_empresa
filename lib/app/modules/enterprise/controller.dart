import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/modules/enterprise/repository.dart';
import 'package:busca_empresa/helpers/app_lifecycle_reactor.dart.dart';
import 'package:busca_empresa/helpers/app_open_ad_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class EnterpriseController extends GetxController
    with StateMixin<EnterpriseModel> {
  final EnterpriseRepository _repository;

  EnterpriseController(this._repository);

  final loadingCircular = ValueNotifier<bool>(false);

  final loading = true.obs;

  var currentPageIndex = 0.obs;

  var colorButton1 = false.obs;
  var colorButton2 = false.obs;
  var colorButton3 = false.obs;
  var colorButton4 = false.obs;

  var startCard = false.obs;

  final bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: 'ca-app-pub-3940256099942544/9257395921',
          listener: const BannerAdListener(),
          request: const AdRequest())
      .obs;

  int _counter = 0;
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void onInit() {
    //loading(true);

    String cnpj = Get.parameters['id']!;

    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();

    _repository.getEnterprise(cnpj).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      print(error.toString());
      if ((error.toString() == "Couldn't resolve host name") ||
          (error.toString() == 'Timeout was reached') ||
          (error.toString() == 'Network is unreachable') ||
          (error.toString() == "Failed host lookup: 'receitaws.com.br'")) {
        Get.offAllNamed('/button_error_conection');
      } else {
        Get.offAllNamed('/button_return');
      }
      //loadingCircular.value = false;
    });
    super.onInit();
  }
}
