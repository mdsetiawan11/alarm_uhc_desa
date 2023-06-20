import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class DinkesBelumTile extends StatefulWidget {
  const DinkesBelumTile({
    Key? key,
  }) : super(key: key);

  @override
  State<DinkesBelumTile> createState() => _DinkesBelumTileState();
}

class _DinkesBelumTileState extends State<DinkesBelumTile> {
  String belum = '';
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
      belum = data[0]['blm'];
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
                  image: AssetImage('lib/images/belum.png'), fit: BoxFit.fill),
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
                  'Penduduk Belum Terdaftar',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  belum + ' Jiwa',
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
