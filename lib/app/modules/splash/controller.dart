import 'dart:async';
import 'package:busca_empresa/app/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    loading();
  }

  Future<void> loading() async {
    Timer(const Duration(seconds: 5), () {
      Get.offAndToNamed(Routes.home);
    });
  }
}
