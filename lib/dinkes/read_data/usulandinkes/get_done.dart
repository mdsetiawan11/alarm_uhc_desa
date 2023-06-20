import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:http/http.dart' as http;
import 'package:loginapp/dinkes/read_data/usulandinkes/detail_done.dart';
import 'package:loginapp/dinkes/read_data/usulandinkes/done.dart';
import 'package:loginapp/shared/colors.dart';

class getDone extends StatefulWidget {
  const getDone({super.key});

  @override
  State<getDone> createState() => _getDoneState();
}

class _getDoneState extends State<getDone> {
  List<Done> alldone = [];
  Future? _future;

  Future getData() async {
    var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/usulandinkesdone/');
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachDone in data) {
      final doneData = Done(
          id: eachDone['id'],
          tahun: eachDone['tahun'],
          bulan: eachDone['bulan'],
          nik: eachDone['nik'],
          nama: eachDone['nama'],
          status: eachDone['status'],
          file: eachDone['file'],
          keterangan: eachDone['keterangan']);
      alldone.add(doneData);
    }
    print(alldone.length);
  }

  List<Done> foundData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = getData();
    foundData = alldone;
  }

  _runFilter(String enteredKeyword) {
    List<Done> hasilCari = [];
    if (enteredKeyword.isEmpty) {
      hasilCari = alldone;
    } else {
      hasilCari = alldone
          .where((data) =>
              data.nama.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundData = hasilCari;
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
                    itemCount: foundData.length,
                    itemBuilder: (context, index) {
                      if (foundData[index].status == 'GAGAL') {
                        return Card(
                          child: ListTile(
                            title: Text(
                              foundData[index].nama,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('NIK'),
                                    Text('Status'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(' : '),
                                    Text(' : '),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(foundData[index].nik),
                                    Text(
                                      foundData[index].status,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.read_more,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailDone(
                                          nik: foundData[index].nik,
                                          nama: foundData[index].nama,
                                          status: foundData[index].status,
                                          keterangan:
                                              foundData[index].keterangan,
                                          file: foundData[index].file),
                                    ));
                              },
                            ),
                          ),
                        );
                      } else {
                        return Card(
                          child: ListTile(
                            title: Text(
                              foundData[index].nama,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('NIK'),
                                    Text('Status'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(' : '),
                                    Text(' : '),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(foundData[index].nik),
                                    Text(
                                      foundData[index].status,
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.read_more,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailDone(
                                          nik: foundData[index].nik,
                                          nama: foundData[index].nama,
                                          status: foundData[index].status,
                                          keterangan:
                                              foundData[index].keterangan,
                                          file: foundData[index].file),
                                    ));
                              },
                            ),
                          ),
                        );
                      }
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
