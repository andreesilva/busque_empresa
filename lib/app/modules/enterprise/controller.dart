import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/modules/enterprise/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterpriseController extends GetxController
    with StateMixin<EnterpriseModel> {
  final EnterpriseRepository _repository;

  EnterpriseController(this._repository);

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

    String cnpj = Get.parameters['id']!;

    _repository.getEnterprise(cnpj).then((data) {
      change(data, status: RxStatus.success());
    }, onError: (error) {
      if ((error.toString() == 'Connection failed') ||
          (error.toString() == 'Network is unreachable') ||
          (error.toString() == 'Connection timed out') ||
          (error.toString() == 'Failed host lookup: receitaws.com.br') ||
          (error.toString() ==
              "FormatException: Unexpected character (at character 1)")) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Sem conexão de rede'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 15),
        ));
      } else if (error.toString() == 'Connection refused') {
        change(null, status: RxStatus.error('Falha no servidor'));
      } else {
        print(error.toString());

        change(null, status: RxStatus.error(error.toString()));
      }
    });
    super.onInit();
  }
}
