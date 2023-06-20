import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loginapp/dinkes/read_data/uhckecdesa/kecamatan.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getKecamatan extends StatefulWidget {
  const getKecamatan({super.key});

  @override
  State<getKecamatan> createState() => _getKecamatanState();
}

class _getKecamatanState extends State<getKecamatan> {
  List<Kecamatan> kecamatans = [];

  Future getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String dati2 = (localStorage.getString('dati2') ?? '');

    var url =
        Uri.parse('https://uhcdesa.jekaen-pky.com/api/allkecamatan/' + dati2);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachKec in data) {
      final kecamatanData = Kecamatan(
          nmkec: eachKec['nmkec'],
          jumlah_penduduk: eachKec['jumlah_penduduk'],
          penduduk_aktif: eachKec['penduduk_aktif'],
          penduduk_nonaktif: eachKec['penduduk_nonaktif'],
          penduduk_belum: eachKec['penduduk_belum'],
          cakupan: eachKec['cakupan']);
      kecamatans.add(kecamatanData);
    }
    print(kecamatans.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: kecamatans.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      kecamatans[index].nmkec,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jumlah Penduduk'),
                            Text('Penduduk Aktif'),
                            Text('Penduduk Nonaktif'),
                            Text('Penduduk Belum Terdaftar'),
                            Text('Cakupan UHC'),
                          ],
                        ),
                        Column(
                          children: [
                            Text(' : '),
                            Text(' : '),
                            Text(' : '),
                            Text(' : '),
                            Text(' : '),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(kecamatans[index].jumlah_penduduk + ' Jiwa'),
                            Text(kecamatans[index].penduduk_aktif + ' Jiwa'),
                            Text(kecamatans[index].penduduk_nonaktif + ' Jiwa'),
                            Text(kecamatans[index].penduduk_belum + ' Jiwa'),
                            Text(kecamatans[index].cakupan + '%'),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Palette.mainColor, size: 30));
          }
        });
  }
}
