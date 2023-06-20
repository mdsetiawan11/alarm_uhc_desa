import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AktifTile extends StatefulWidget {
  const AktifTile({
    Key? key,
  }) : super(key: key);

  @override
  State<AktifTile> createState() => _AktifTileState();
}

class _AktifTileState extends State<AktifTile> {
  String aktif = '';
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
      aktif = data['penduduk_aktif'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
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
                child: Image.asset('lib/images/aktif.png')),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
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
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    aktif + ' Jiwa',
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
