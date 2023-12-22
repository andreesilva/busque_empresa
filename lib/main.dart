import 'package:busca_empresa/app/core/theme/app_theme.dart';
import 'package:busca_empresa/app/data/provider/api.dart';
import 'package:busca_empresa/app/routes/pages.dart';
import 'package:busca_empresa/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.put<Api>(Api());

  Intl.defaultLocale = "pt_BR";

  RendererBinding.instance.setSemanticsEnabled(true);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.splash,
    theme: themeData,
    getPages: AppPages.pages,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ],
    locale: const Locale('pt', 'BR'),
    supportedLocales: const [Locale("pt", "BR")],
  ));
}
