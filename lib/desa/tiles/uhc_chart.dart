import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UhcChart extends StatefulWidget {
  const UhcChart({super.key});

  @override
  State<UhcChart> createState() => _UhcChartState();
}

class _UhcChartState extends State<UhcChart> {
  String kddesa = '';
  double terdaftar = 0;
  double belum = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String dati2 = (localStorage.getString('dati2') ?? '');
    var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/uhc/' + dati2);
    var response = await http.get(url);
    var data = await json.decode(response.body);
    setState(() {
      terdaftar = double.parse(data[0]['terdaftar']);
      belum = double.parse(data[0]['belum']);
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Penduduk Terdaftar": terdaftar,
      "Penduduk Belum Terdaftar": belum,
    };

    return PieChart(
      dataMap: dataMap,

      animationDuration: Duration(milliseconds: 300),
      chartLegendSpacing: 15,
      colorList: [Colors.green, Colors.red],
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 20,

      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 2,
        chartValueStyle: GoogleFonts.poppins(
          color: Colors.black,
        ),
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    );
  }
}
