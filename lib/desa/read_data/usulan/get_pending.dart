import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/desa/read_data/usulan/pending.dart';
import 'package:loginapp/desa/read_data/usulan/show_pdf.dart';
import 'package:loginapp/desa/read_data/usulan/usulan_baru.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getPending extends StatefulWidget {
  const getPending({super.key});

  @override
  State<getPending> createState() => _getPendingState();
}

class _getPendingState extends State<getPending> {
  List<Pending> allpending = [];

  Future getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    String kddesa = (localStorage.getString('kddesa') ?? '');
    var url = Uri.parse(
        'https://uhcdesa.jekaen-pky.com/api/usulandesapending/' + kddesa);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachPending in data) {
      final pendingData = Pending(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 0,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UsulanBaruPage(),
              ));
        },
        backgroundColor: Palette.mainColor,
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: allpending.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          allpending[index].nama,
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
                                Text(allpending[index].nik),
                                Text(allpending[index].status),
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                            color: Colors.red.shade800,
                            highlightColor: Colors.red.shade100,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowPDF(
                                        nama: allpending[index].nama,
                                        file: allpending[index].file),
                                  ));
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidFilePdf,
                            )),
                      ),
                    );
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
