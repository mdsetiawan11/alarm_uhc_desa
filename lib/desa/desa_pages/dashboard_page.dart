// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:loginapp/desa/tiles/aktif_tile.dart';
import 'package:loginapp/desa/tiles/belum_tile.dart';
import 'package:loginapp/desa/tiles/cakupan_tile.dart';
import 'package:loginapp/desa/tiles/nonaktif_tile.dart';
import 'package:loginapp/desa/tiles/penduduk_tile.dart';
import 'package:loginapp/desa/tiles/uhc_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String nama = '';
  String kddesa = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      nama = (localStorage.getString('nama') ?? '');
      kddesa = (localStorage.getString('kddesa') ?? '');
    });
    var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/desa/' + kddesa);
    var response = await http.get(url);
    var data = await json.decode(response.body) as Map<String, dynamic>;
    print(data);
  }

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
                flex: 4,
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
                  'DATA UHC ' + nama.toUpperCase(),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      PendudukTile(),
                      AktifTile(),
                      NonaktifTile(),
                      BelumTile(),
                      CakupanTile(),
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
                  'UHC KAB. KATINGAN',
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
                flex: 4,
                child: UhcChart(),
              ),
            ]),
      ),
    );
  }
}
