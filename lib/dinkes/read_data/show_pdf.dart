import 'package:flutter/material.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPDF extends StatelessWidget {
  final String nama;
  final String file;
  ShowPDF({Key? key, required this.nama, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Text(
          'BERKAS ' + nama,
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
      body: Container(
        child: SfPdfViewer.network(
            'https://uhcdesa.jekaen-pky.com/assets/usulandinkes/' + file),
      ),
    );
  }
}
