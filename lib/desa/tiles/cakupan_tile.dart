import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CakupanTile extends StatefulWidget {
  const CakupanTile({
    Key? key,
  }) : super(key: key);

  @override
  State<CakupanTile> createState() => _CakupanTileState();
}

class _CakupanTileState extends State<CakupanTile> {
  String cakupan = '';
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
      cakupan = data['cakupan'];
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
                child: Image.asset('lib/images/cakupan.png')),
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
                    'Cakupan Kepesertaan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.pink,
                    ),
                  ),
                  Text(
                    cakupan + ' %',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
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
