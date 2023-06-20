import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DinsosAktifTile extends StatefulWidget {
  const DinsosAktifTile({
    Key? key,
  }) : super(key: key);

  @override
  State<DinsosAktifTile> createState() => _DinkesAktifTileState();
}

class _DinkesAktifTileState extends State<DinsosAktifTile> {
  String aktif = '';
  String dati2 = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      dati2 = (localStorage.getString('dati2') ?? '');
    });
    var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/uhc/' + dati2);
    var response = await http.get(url);
    var data = await json.decode(response.body);

    setState(() {
      aktif = data[0]['aktif'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/images/aktif.png'), fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 5.0,
              left: 5.0,
              right: 5.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Penduduk Aktif',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  aktif + ' Jiwa',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
