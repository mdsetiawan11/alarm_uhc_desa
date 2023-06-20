import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loginapp/dinsos/read_data/desa.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getDesa extends StatefulWidget {
  const getDesa({super.key});

  @override
  State<getDesa> createState() => _getDesaState();
}

class _getDesaState extends State<getDesa> {
  List<Desa> alldesa = [];

  Future getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String dati2 = (localStorage.getString('dati2') ?? '');

    var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/alldesa/' + dati2);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachDesa in data) {
      final desaData = Desa(
          nmdesa: eachDesa['nmdesa'],
          jumlah_penduduk: eachDesa['jumlah_penduduk'],
          penduduk_aktif: eachDesa['penduduk_aktif'],
          penduduk_nonaktif: eachDesa['penduduk_nonaktif'],
          penduduk_belum: eachDesa['penduduk_belum'],
          cakupan: eachDesa['cakupan']);
      alldesa.add(desaData);
    }
    print(alldesa.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: alldesa.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      alldesa[index].nmdesa,
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
                            Text(alldesa[index].jumlah_penduduk + ' Jiwa'),
                            Text(alldesa[index].penduduk_aktif + ' Jiwa'),
                            Text(alldesa[index].penduduk_nonaktif + ' Jiwa'),
                            Text(alldesa[index].penduduk_belum + ' Jiwa'),
                            Text(alldesa[index].cakupan + '%'),
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
