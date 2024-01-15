import 'package:busca_empresa/app/modules/button_error_conection/controller.dart';
import 'package:get/get.dart';

class ButtonErrorConectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ButtonErrorConectionController>(
        () => ButtonErrorConectionController());
  }
}
