import 'package:busca_empresa/app/data/provider/api.dart';
import 'package:busca_empresa/app/modules/about/controller.dart';
import 'package:busca_empresa/app/modules/enterprise/controller.dart';
import 'package:busca_empresa/app/modules/enterprise/repository.dart';
import 'package:get/get.dart';

class AboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController());
  }
}
