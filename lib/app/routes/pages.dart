import 'package:busca_empresa/app/modules/about/binding.dart';
import 'package:busca_empresa/app/modules/about/page.dart';
import 'package:busca_empresa/app/modules/button_error_conection/binding.dart';
import 'package:busca_empresa/app/modules/button_error_conection/page.dart';
import 'package:busca_empresa/app/modules/button_return/binding.dart';
import 'package:busca_empresa/app/modules/button_return/page.dart';
import 'package:busca_empresa/app/modules/enterprise/binding.dart';
import 'package:busca_empresa/app/modules/enterprise/page.dart';
import 'package:busca_empresa/app/modules/home/binding.dart';
import 'package:busca_empresa/app/modules/home/page.dart';
import 'package:busca_empresa/app/modules/splash/binding.dart';
import 'package:busca_empresa/app/modules/splash/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.enterprise,
      page: () => EnterprisePage(),
      binding: EnterpriseBinding(),
    ),
    GetPage(
      name: Routes.about,
      page: () => AboutPage(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: Routes.button_return,
      page: () => ButtonReturnPage(),
      binding: ButtonReturnBinding(),
    ),
    GetPage(
      name: Routes.button_error_conection,
      page: () => ButtonErrorConectionPage(),
      binding: ButtonErrorConectionBinding(),
    ),
  ];
}

class RedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return null;
  }
}
