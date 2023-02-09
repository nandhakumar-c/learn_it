import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xff092b65, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff092b65), //10%
      100: const Color(0xff08275b), //20%
      200: const Color(0xff061e47), //30%
      300: const Color(0xff061e47), //40%
      400: const Color(0xff051a3d), //50%
      500: const Color(0xff051633), //60%
      600: const Color(0xff041128), //70%
      700: const Color(0xff030d1e), //80%
      800: const Color(0xff020914), //90%
      900: const Color(0xff01040a), //100%
    },
  );
} //
