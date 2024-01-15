import 'package:get/get.dart';

class ButtonErrorConectionController extends GetxController {
  final loading = true.obs;

  @override
  void onInit() {
    loading(true);

    super.onInit();
  }
}
