import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/desa/read_data/usulan/proses.dart';

import 'package:loginapp/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

class getProses extends StatefulWidget {
  const getProses({super.key});

  @override
  State<getProses> createState() => _getProsesState();
}

class _getProsesState extends State<getProses> {
  List<Proses> allpending = [];

  Future getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String kddesa = (localStorage.getString('kddesa') ?? '');
    var url = Uri.parse(
        'https://uhcdesa.jekaen-pky.com/api/usulandesaproses/' + kddesa);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachPending in data) {
      final pendingData = Proses(
          id: eachPending['id'],
          nik: eachPending['nik'],
          nama: eachPending['nama'],
          status: eachPending['status'],
          file: eachPending['file'],
          keterangan: eachPending['keterangan']);
      allpending.add(pendingData);
    }
    print(allpending.length);
  }

  Future refreshData() async {
    setState(() {
      allpending = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: allpending.length,
                  itemBuilder: (context, index) {
                    if (allpending[index].status == 'DISETUJUI DINSOS') {
                      return Card(
                        child: ListTile(
                          title: Text(
                            allpending[index].nama,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('NIK : ' + allpending[index].nik),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 50,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      isFirst: true,
                                      indicatorStyle:
                                          IndicatorStyle(color: Colors.green),
                                      afterLineStyle:
                                          LineStyle(color: Colors.green),
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Usulan',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      indicatorStyle:
                                          IndicatorStyle(color: Colors.green),
                                      beforeLineStyle:
                                          LineStyle(color: Colors.green),
                                      afterLineStyle:
                                          LineStyle(color: Colors.green),
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Verifikasi',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'Dinsos',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      indicatorStyle:
                                          IndicatorStyle(color: Colors.green),
                                      beforeLineStyle:
                                          LineStyle(color: Colors.green),
                                      afterLineStyle:
                                          LineStyle(color: Colors.grey),
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Persetujuan',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'Dinkes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Proses'),
                                          Text('BPJS Kes')
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 50,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      isLast: true,
                                      endChild: Text('Selesai'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    if (allpending[index].status == 'DISETUJUI') {
                      return Card(
                        child: ListTile(
                          title: Text(
                            allpending[index].nama,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('NIK : ' + allpending[index].nik),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 50,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      isFirst: true,
                                      indicatorStyle:
                                          IndicatorStyle(color: Colors.green),
                                      afterLineStyle:
                                          LineStyle(color: Colors.green),
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Usulan',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      indicatorStyle:
                                          IndicatorStyle(color: Colors.green),
                                      beforeLineStyle:
                                          LineStyle(color: Colors.green),
                                      afterLineStyle:
                                          LineStyle(color: Colors.green),
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Verifikasi',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'Dinsos',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      indicatorStyle:
                                          IndicatorStyle(color: Colors.green),
                                      beforeLineStyle:
                                          LineStyle(color: Colors.green),
                                      afterLineStyle:
                                          LineStyle(color: Colors.green),
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Persetujuan',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'Dinkes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 100,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      indicatorStyle:
                                          IndicatorStyle(color: Colors.green),
                                      beforeLineStyle:
                                          LineStyle(color: Colors.green),
                                      afterLineStyle:
                                          LineStyle(color: Colors.grey),
                                      endChild: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Proses',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            'BPJS Kes',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    width: 50,
                                    child: TimelineTile(
                                      axis: TimelineAxis.horizontal,
                                      alignment: TimelineAlign.start,
                                      isLast: true,
                                      endChild: Text('Selesai'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                );
              } else {
                return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: Palette.mainColor, size: 30));
              }
            }),
      ),
    );
  }
}
