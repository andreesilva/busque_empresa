import 'package:busca_empresa/app/data/models/enterprise.dart';
import 'package:busca_empresa/app/modules/home/repository.dart';
import 'package:busca_empresa/app/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomeController extends GetxController with StateMixin<EnterpriseModel> {
  final HomeRepository _repository;

  HomeController(this._repository);

  final formKey = GlobalKey<FormState>();

  var typedText = TextEditingController();

  final loadingCircular = ValueNotifier<bool>(false);

  final loading = true.obs;
  String cnpj = " ";

  var cn = false.obs;

  @override
  void onInit() {
    loading(true);

    searchEnterprise(cnpj);

    super.onInit();
  }

  submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    var noPoint = typedText.value.text.replaceAll('.', '');
    var withoutBar = noPoint.replaceAll('/', '');
    var noTrace = withoutBar.replaceAll('-', '');

    searchEnterprise(noTrace);

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
      if ((error.toString() == 'Connection failed') ||
          (error.toString() == 'Network is unreachable') ||
          (error.toString() == 'Connection timed out') ||
          (error.toString() == "Failed host lookup: 'receitaws.com.br'")) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(const SnackBar(
          content: Text('Sem conexão de rede'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 15),
        ));
      } else {
        print(error.toString());
      }

      loading(false);
    });
  }

  String removeTrace(cnpj) {
    var noPoint = cnpj.replaceAll('.', '');
    var withoutBar = noPoint.replaceAll('/', '');
    var noTrace = withoutBar.replaceAll('-', '');

    return noTrace;
  }
}
