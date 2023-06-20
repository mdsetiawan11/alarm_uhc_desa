import 'package:flutter/material.dart';

Color primaryColor() => const Color(0xff1C4596);

class Palette {
  static const MaterialColor mainColor = const MaterialColor(
    0xff1c4596, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff193e87), //10%
      100: const Color(0xff163778), //20%
      200: const Color(0xff143069), //30%
      300: const Color(0xff11295a), //40%
      400: const Color(0xff0e234b), //50%
      500: const Color(0xff0b1c3c), //60%
      600: const Color(0xff08152d), //70%
      700: const Color(0xff060e1e), //80%
      800: const Color(0xff03070f), //90%
      900: const Color(0xff000000), //100%
    },
  );
} // you ca
