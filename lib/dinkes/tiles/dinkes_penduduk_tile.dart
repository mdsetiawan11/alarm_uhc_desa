import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DinkesPendudukTile extends StatefulWidget {
  const DinkesPendudukTile({
    Key? key,
  }) : super(key: key);

  @override
  State<DinkesPendudukTile> createState() => _PendudukTileState();
}

class _PendudukTileState extends State<DinkesPendudukTile> {
  String jumlah = '';
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
      jumlah = data[0]['jumlah_penduduk'];
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
                  image: AssetImage('lib/images/penduduk.png'),
                  fit: BoxFit.fill),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jumlah Penduduk',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  jumlah + ' Jiwa',
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
