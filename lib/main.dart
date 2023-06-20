import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginapp/auth_pages/intro_screen.dart';
import 'package:loginapp/dinkes/dinkes_pages/home_dinkes.dart';
import 'package:loginapp/dinsos/dinsos_pages/home_dinsos.dart';

import 'package:loginapp/shared/colors.dart';
import 'package:loginapp/desa/desa_pages/home_desa.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();

  var level = (localStorage.getString('level') ?? '');
  var intro = (localStorage.getString('intro') ?? '');

  print(level);
  runApp(MyApp(level: level, intro: intro));
}

class MyApp extends StatelessWidget {
  final String level;
  final String intro;
  const MyApp({super.key, required this.level, required this.intro});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primarySwatch: Palette.mainColor,
      ),
      debugShowCheckedModeBanner: false,
      home: level == "" && intro == ""
          ? const IntroScreen()
          : level == "2" && intro == "sudah"
              ? const HomeDesa()
              : level == "3" && intro == "sudah"
                  ? const HomeDinsos()
                  : level == "4" && intro == "sudah"
                      ? const HomeDinkes()
                      : const IntroScreen(),
    );
  }
}
