import 'package:busca_empresa/app/core/theme/colors.app.dart';
import 'package:busca_empresa/app/modules/splash/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsApp.orange,
        child: Center(child: Image.asset('assets/logo.png')),
      ),
    );
  }
}
