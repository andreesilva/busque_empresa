import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/modules/enterprise/repository.dart';
import 'package:get/get.dart';

class AboutController extends GetxController {
  final loading = true.obs;

  var currentPageIndex = 0.obs;

  var colorButton1 = false.obs;
  var colorButton2 = false.obs;
  var colorButton3 = false.obs;
  var colorButton4 = false.obs;

  var startCard = false.obs;

  @override
  void onInit() {
    loading(true);

    super.onInit();
  }
}
