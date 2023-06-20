import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/dinkes/read_data/usulandesa/desa_pending.dart';
import 'package:loginapp/dinkes/read_data/show_pdf.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class getDesaPending extends StatefulWidget {
  const getDesaPending({super.key});

  @override
  State<getDesaPending> createState() => _getDesaPendingState();
}

class _getDesaPendingState extends State<getDesaPending> {
  List<UsulanDesaPending> allpending = [];

  Future getData() async {
    var url = Uri.parse(
        'https://uhcdesa.jekaen-pky.com/api/usulandesafordinkespending/');
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachPending in data) {
      final pendingData = UsulanDesaPending(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 0,
        onPressed: () {
          approveall();
        },
        backgroundColor: Palette.mainColor,
        child: Icon(Icons.check),
      ),
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

  void approveall() {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.scale,
            title: 'Setujui Semua Usulan',
            desc: 'Apakah anda yakin ingin menyetujui semua usulan dari desa ?',
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              try {
                var url = Uri.parse(
                    'https://uhcdesa.jekaen-pky.com/api/dinkesapproveall/');
                var response = await http.put(
                  url,
                );

                if (response.statusCode == 200) {
                  setState(() {
                    allpending = [];
                  });
                  Fluttertoast.showToast(
                    msg: 'Usulan berhasil disetujui semua',
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
            btnOkText: 'Ya')
        .show();
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
              Uri.parse('https://uhcdesa.jekaen-pky.com/api/dinkestolakdesa/');
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
              'https://uhcdesa.jekaen-pky.com/api/dinkesapprovedesa/');
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
