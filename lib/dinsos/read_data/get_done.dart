import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:http/http.dart' as http;
import 'package:loginapp/dinsos/read_data/detail_done.dart';
import 'package:loginapp/dinsos/read_data/done.dart';
import 'package:loginapp/shared/colors.dart';

class getDone extends StatefulWidget {
  const getDone({super.key});

  @override
  State<getDone> createState() => _getDoneState();
}

class _getDoneState extends State<getDone> {
  List<Done> alldone = [];

  Future getData() async {
    var url = Uri.parse(
        'https://uhcdesa.jekaen-pky.com/api/usulandesafordinsosselesai/');
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachDone in data) {
      final doneData = Done(
          id: eachDone['id'],
          nik: eachDone['nik'],
          nama: eachDone['nama'],
          nmdesa: eachDone['nmdesa'],
          status: eachDone['status'],
          file: eachDone['file'],
          keterangan: eachDone['keterangan']);
      alldone.add(doneData);
    }
    print(alldone.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: alldone.length,
              itemBuilder: (context, index) {
                if (alldone[index].status == 'GAGAL') {
                  return Card(
                    child: ListTile(
                      title: Text(
                        alldone[index].nama,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NIK'),
                              Text('Desa'),
                              Text('Status'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(' : '),
                              Text(' : '),
                              Text(' : '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(alldone[index].nik),
                              Text(alldone[index].nmdesa),
                              Text(
                                alldone[index].status,
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
                                    nik: alldone[index].nik,
                                    nama: alldone[index].nama,
                                    status: alldone[index].status,
                                    keterangan: alldone[index].keterangan,
                                    file: alldone[index].file),
                              ));
                        },
                      ),
                    ),
                  );
                } else {
                  return Card(
                    child: ListTile(
                      title: Text(
                        alldone[index].nama,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('NIK'),
                              Text('Desa'),
                              Text('Status'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(' : '),
                              Text(' : '),
                              Text(' : '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(alldone[index].nik),
                              Text(alldone[index].nmdesa),
                              Text(
                                alldone[index].status,
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
                                    nik: alldone[index].nik,
                                    nama: alldone[index].nama,
                                    status: alldone[index].status,
                                    keterangan: alldone[index].keterangan,
                                    file: alldone[index].file),
                              ));
                        },
                      ),
                    ),
                  );
                }
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
