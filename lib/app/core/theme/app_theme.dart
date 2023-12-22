import 'package:busca_empresa/app/core/theme/colors.app.dart';
import 'package:flutter/material.dart';

var colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
);

var radioTheme = RadioThemeData(
  fillColor: MaterialStateColor.resolveWith((states) => colorScheme.primary),
);

var elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary));

final ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: const Color(0xffFAFAFA),
  colorScheme: colorScheme,
  useMaterial3: true,
  radioTheme: radioTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: ColorsApp.orange),
    elevation: 0,
    shadowColor: Colors.white,
  ),
);
