// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:loginapp/desa/read_data/bnba/get_belum_terdaftar.dart';
import 'package:loginapp/desa/read_data/bnba/get_menunggak.dart';
import 'package:loginapp/desa/read_data/bnba/get_nonaktif.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  //

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 50,
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.white),
                insets: EdgeInsets.symmetric(horizontal: 30.0)),
            indicatorColor: Colors.grey.shade50,
            tabs: [
              Tab(
                text: 'Nonaktif',
              ),
              Tab(
                text: 'Menunggak',
              ),
              Tab(
                text: 'Belum Terdaftar',
              )
            ],
          ),
          title: Text(
            'DATA',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          titleSpacing: 20,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Palette.mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
          ),
        ),
        body: TabBarView(
          children: const [getNonaktif(), getMenunggak(), getBelumTerdaftar()],
        ),
      ),
    );
  }
}
