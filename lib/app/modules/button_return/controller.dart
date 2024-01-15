import 'dart:async';

import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/modules/button_return/repository.dart';
import 'package:busca_empresa/app/routes/routes.dart';
import 'package:get/get.dart';

class ButtonReturnController extends GetxController {
  final ButtonReturnRepository _repository;

  ButtonReturnController(this._repository);

  var variableTimer = false.obs;

  var timeLeft = 30.obs;

  @override
  void onInit() {
    startTimer();

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
        variableTimer.value = true;
        timer.cancel();
      }
    });
  }

  loading() {
    Get.offAllNamed(Routes.home);
  }
}
