import 'package:busca_empresa/app/data/provider/api.dart';
import 'package:busca_empresa/app/modules/button_return/controller.dart';
import 'package:busca_empresa/app/modules/button_return/repository.dart';
import 'package:get/get.dart';

class ButtonReturnBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ButtonReturnController>(
        () => ButtonReturnController(ButtonReturnRepository(Get.find<Api>())));
  }
}
