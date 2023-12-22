import 'package:busca_empresa/app/core/theme/colors.app.dart';
import 'package:flutter/material.dart';

final button = ElevatedButton.styleFrom(
  backgroundColor: ColorsApp.orange,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6),
  ),
  elevation: 2,
  shadowColor: Colors.blueGrey,
);

final button_2 = ElevatedButton.styleFrom(
  backgroundColor: ColorsApp.orange,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6),
  ),
  elevation: 2,
  shadowColor: Colors.blueGrey,
);

final button_menu = ElevatedButton.styleFrom(
  textStyle: const TextStyle(color: Colors.black),
  backgroundColor: ColorsApp.button_menu_origin,
  shape: RoundedRectangleBorder(
    side: const BorderSide(width: 0, color: Colors.white),
    borderRadius: BorderRadius.circular(6),
  ),
  elevation: 0,
  shadowColor: Colors.white,
).merge(ButtonStyle(
  overlayColor:
      MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return Colors.green;
    } else {
      return ColorsApp.button_menu;
    }
  }),
));
