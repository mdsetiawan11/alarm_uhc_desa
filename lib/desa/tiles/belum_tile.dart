import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BelumTile extends StatefulWidget {
  const BelumTile({
    Key? key,
  }) : super(key: key);

  @override
  State<BelumTile> createState() => _BelumTileState();
}

class _BelumTileState extends State<BelumTile> {
  String belum = '';
  String kddesa = '';
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      kddesa = (localStorage.getString('kddesa') ?? '');
    });
    var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/desa/' + kddesa);
    var response = await http.get(url);
    var data = await json.decode(response.body) as Map<String, dynamic>;

    print(data);
    setState(() {
      belum = data['penduduk_belum'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 150,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            SizedBox(
                width: 70,
                height: 70,
                child: Image.asset('lib/images/belum.png')),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 3.0,
                right: 3.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penduduk Belum Terdaftar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    belum + ' Jiwa',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
