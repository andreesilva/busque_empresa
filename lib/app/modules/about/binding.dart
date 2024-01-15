import 'package:busca_empresa/app/modules/about/controller.dart';
import 'package:get/get.dart';

class AboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
}
