import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/dinkes/tiles/dinkes_aktif_tile.dart';
import 'package:loginapp/dinkes/tiles/dinkes_belum_tile.dart';
import 'package:loginapp/dinkes/tiles/dinkes_nonaktif_tile.dart';
import 'package:loginapp/dinkes/tiles/dinkes_penduduk_tile.dart';
import 'package:loginapp/dinkes/tiles/dinkes_uhc_chart.dart';
import 'package:loginapp/shared/colors.dart';

class DashboardDinkesPage extends StatefulWidget {
  const DashboardDinkesPage({super.key});

  @override
  State<DashboardDinkesPage> createState() => _DashboardDinkesPageState();
}

class _DashboardDinkesPageState extends State<DashboardDinkesPage> {
  final List<String> infoList = [
    'lib/images/info/nik.jpeg',
    'lib/images/info/cek.jpg',
    'lib/images/info/skrining.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Text(
          'DASHBOARD',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Palette.mainColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(autoPlay: true),
                    items: infoList
                        .map((item) => Container(
                              child: Center(
                                  child: Image.asset(item, fit: BoxFit.fill)),
                            ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'DATA UHC',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      DinkesPendudukTile(),
                      DinkesAktifTile(),
                      DinkesNonaktifTile(),
                      DinkesBelumTile(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'CAKUPAN UHC',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 3,
                child: UhcChart(),
              ),
            ]),
      ),
    );
  }
}
