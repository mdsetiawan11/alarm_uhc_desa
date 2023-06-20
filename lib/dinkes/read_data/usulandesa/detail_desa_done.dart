import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginapp/dinkes/read_data/show_pdf.dart';
import 'package:loginapp/shared/colors.dart';

class DetailDesaDone extends StatelessWidget {
  final String nik;
  final String nama;
  final String status;
  final String keterangan;
  final String file;
  DetailDesaDone(
      {Key? key,
      required this.nik,
      required this.nama,
      required this.file,
      required this.status,
      required this.keterangan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Text(
          'DETAIL ' + nama,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Palette.mainColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NIK : ',
              style: TextStyle(fontSize: 18),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  nik,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Text(
              'Status : ',
              style: TextStyle(fontSize: 18),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Text(
              'Keterangan : ',
              style: TextStyle(fontSize: 18),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  keterangan,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                ),
              ),
            ),
            Text(
              'Berkas : ',
              style: TextStyle(fontSize: 18),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    color: Colors.red.shade800,
                    highlightColor: Colors.red.shade100,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShowPDF(nama: nama, file: file),
                          ));
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.solidFilePdf,
                      size: 35,
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
