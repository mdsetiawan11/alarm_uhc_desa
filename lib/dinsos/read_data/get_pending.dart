import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/dinsos/read_data/pending.dart';
import 'package:loginapp/dinsos/read_data/show_pdf.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class getPending extends StatefulWidget {
  const getPending({super.key});

  @override
  State<getPending> createState() => _getPendingState();
}

class _getPendingState extends State<getPending> {
  List<Pending> allpending = [];

  Future getData() async {
    var url = Uri.parse(
        'https://uhcdesa.jekaen-pky.com/api/usulandesafordinsospending/');
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachPending in data) {
      final pendingData = Pending(
          id: eachPending['id'],
          nik: eachPending['nik'],
          nama: eachPending['nama'],
          nmdesa: eachPending['nmdesa'],
          status: eachPending['status'],
          file: eachPending['file'],
          keterangan: eachPending['keterangan']);
      allpending.add(pendingData);
    }
    print(allpending.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: allpending.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (context) => tolak(
                                allpending[index].id,
                                allpending[index].nama,
                                allpending[index].nmdesa),
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.close,
                            label: 'Tolak',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (context) => approve(
                                allpending[index].id,
                                allpending[index].nama,
                                allpending[index].nmdesa),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: Icons.check,
                            label: 'Setujui',
                          ),
                        ],
                      ),
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
                                Text('Desa/Kelurahan'),
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
                                Text(allpending[index].nik),
                                Text(allpending[index].nmdesa),
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
    );
  }

  void tolak(String id, String nama, String nmdesa) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: 'Tolak Usulan',
      desc: 'Apakah anda yakin ingin menolak usulan a.n $nama dari $nmdesa ?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        print(id);
        try {
          var url =
              Uri.parse('https://uhcdesa.jekaen-pky.com/api/dinsostolakdesa/');
          var response = await http.put(
            url,
            body: {
              "id": id,
            },
          );

          if (response.statusCode == 200) {
            setState(() {
              allpending = [];
            });
            Fluttertoast.showToast(
              msg: 'Usulan berhasil ditolak',
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Usulan gagal ditolak, silahkan coba lagi',
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: 'Usulan gagal ditolak, silahkan coba lagi',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      btnCancelText: 'Batal',
      btnOkText: 'Ya',
    )..show();
  }

  void approve(String id, String nama, String nmdesa) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'Setujui Usulan',
      desc:
          'Apakah anda yakin ingin menyetujui usulan a.n $nama dari $nmdesa ?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        print(id);
        try {
          var url = Uri.parse(
              'https://uhcdesa.jekaen-pky.com/api/dinsosapprovedesa/');
          var response = await http.put(
            url,
            body: {
              "id": id,
            },
          );

          if (response.statusCode == 200) {
            setState(() {
              allpending = [];
            });
            Fluttertoast.showToast(
              msg: 'Usulan berhasil disetujui',
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Usulan gagal disetujui, silahkan coba lagi',
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        } catch (e) {
          Fluttertoast.showToast(
            msg: 'Usulan gagal disetujui, silahkan coba lagi',
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      btnCancelText: 'Batal',
      btnOkText: 'Ya',
    )..show();
  }
}
