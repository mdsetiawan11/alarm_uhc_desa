import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:loginapp/auth_pages/login_page.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 18),
        bodyPadding: EdgeInsets.all(16));
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      dotsFlex: 3,
      pages: [
        PageViewModel(
            title: 'Dashboard',
            body:
                'Lihat cakupan Universal Health Coverage, sudahkah semua penduduk anda terdaftar JKN.',
            decoration: pageDecoration,
            image: SvgPicture.asset(
              'lib/images/dashboard.svg',
              width: 350,
            )),
        PageViewModel(
            title: 'Usulan',
            body: 'Monitor progres usulan, sudah sampai manakah usulan anda.',
            decoration: pageDecoration,
            image: SvgPicture.asset(
              'lib/images/progres.svg',
              width: 350,
            )),
        PageViewModel(
            title: 'Mobile',
            body:
                'Kini semua dalam genggaman, dimanapun dan kapanpun Alarm UHC Desa dapat diakses dengan mudah',
            decoration: pageDecoration,
            image: SvgPicture.asset(
              'lib/images/mobile.svg',
              width: 200,
            ))
      ],
      onDone: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      },
      showSkipButton: true,
      showDoneButton: true,
      showNextButton: true,
      showBackButton: false,
      back: Icon(Icons.arrow_back),
      skip: Text('Skip'),
      next: Icon(Icons.arrow_forward),
      done: Text('Login'),
      dotsDecorator: DotsDecorator(
          color: Colors.grey,
          size: Size(10, 10),
          activeSize: Size(22, 10),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
    );
  }
}
