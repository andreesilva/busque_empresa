import 'dart:async';

import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/modules/home/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeController extends GetxController with StateMixin<EnterpriseModel> {
  final HomeRepository _repository;

  HomeController(this._repository);

  final formKey = GlobalKey<FormState>();

  var typedText = TextEditingController();

  final loadingCircular = ValueNotifier<bool>(false);

  final loading = true.obs;
  String cnpj = " ";

  var cn = false.obs;
  var variableTimer = false.obs;
  var clickedButton = false.obs;

  var timeLeft = 0.obs;

  @override
  void onInit() {
    loading(true);

    searchEnterprise(cnpj);

    super.onInit();
  }

  //Temporizador que só deixa fazer uma nova consulta depois de 20 segundos. A api da receita só deixa fazer 3 requisições por minuto, no plano gratuito.
  startTimer() {
    const duration = Duration(seconds: 1);

    Timer.periodic(duration, (timer) {
      print(timer.tick);
      if (timeLeft > 0) {
        timeLeft = timeLeft - 1;
      } else {
        variableTimer.value = false;
        timer.cancel();
      }
    });
  }

  submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    var noPoint = typedText.value.text.replaceAll('.', '');
    var withoutBar = noPoint.replaceAll('/', '');
    var noTrace = withoutBar.replaceAll('-', '');

    searchEnterprise(noTrace);

    typedText.clear();

    loadingCircular.value = false;
  }

  searchEnterprise(cnpj_) async {
    if (typedText.value.text == "") {
      cnpj = "06947283000160"; //Cnpj do google
    } else {
      cnpj = cnpj_;
    }

    var noPoint = cnpj.replaceAll('.', '');
    var withoutBar = noPoint.replaceAll('/', '');
    var noTrace = withoutBar.replaceAll('-', '');

    _repository.getClient(noTrace).then((data) {
      change(data, status: RxStatus.success());

      loading(false);
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

      loadingCircular.value = false;
    });
  }

  String removeTrace(cnpj) {
    var noPoint = cnpj.replaceAll('.', '');
    var withoutBar = noPoint.replaceAll('/', '');
    var noTrace = withoutBar.replaceAll('-', '');

    return noTrace;
  }
}
