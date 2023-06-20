import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loginapp/dinkes/read_data/uhckecdesa/desa.dart';
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
  Future? _future;

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

  List<Desa> foundDesa = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getData();
    foundDesa = alldesa;
  }

  _runFilter(String enteredKeyword) {
    List<Desa> hasilCari = [];
    if (enteredKeyword.isEmpty) {
      hasilCari = alldesa;
    } else {
      hasilCari = alldesa
          .where((namaDesa) => namaDesa.nmdesa
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundDesa = hasilCari;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: InputDecoration(
                        labelText: 'Cari', suffixIcon: Icon(Icons.search)),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: foundDesa.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            foundDesa[index].nmdesa,
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
                                  Text(foundDesa[index].jumlah_penduduk +
                                      ' Jiwa'),
                                  Text(foundDesa[index].penduduk_aktif +
                                      ' Jiwa'),
                                  Text(foundDesa[index].penduduk_nonaktif +
                                      ' Jiwa'),
                                  Text(foundDesa[index].penduduk_belum +
                                      ' Jiwa'),
                                  Text(foundDesa[index].cakupan + '%'),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Palette.mainColor, size: 30));
          }
        });
  }
}
