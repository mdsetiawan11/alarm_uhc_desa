import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginapp/dinsos/read_data/done.dart';
import 'package:loginapp/dinsos/read_data/get_done.dart';
import 'package:loginapp/dinsos/read_data/get_pending.dart';
import 'package:loginapp/dinsos/read_data/pending.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class UsulanDinsosPage extends StatefulWidget {
  const UsulanDinsosPage({super.key});

  @override
  State<UsulanDinsosPage> createState() => _UsulanDinsosPageState();
}

class _UsulanDinsosPageState extends State<UsulanDinsosPage> {
  List<Pending> allpending = [];
  List<Done> alldone = [];

  getJumlahUsulanDesaPending() async {
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
    setState(() {
      allpending.length;
    });
  }

  getJumlahUsulanDesaDone() async {
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
    setState(() {
      alldone.length;
    });
  }

  @override
  void initState() {
    getJumlahUsulanDesaPending();
    getJumlahUsulanDesaDone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                icon: badges.Badge(
                  showBadge: allpending.length > 0 ? true : false,
                  position: badges.BadgePosition.topEnd(top: -20, end: -20),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.white,
                    elevation: 0,
                  ),
                  badgeContent: Text(
                    allpending.length.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                  child: Text('Pending'),
                ),
              ),
              Tab(
                icon: badges.Badge(
                  showBadge: alldone.length > 0 ? true : false,
                  position: badges.BadgePosition.topEnd(top: -20, end: -20),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.white,
                    elevation: 0,
                  ),
                  badgeContent: Text(
                    alldone.length.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                  child: Text('Done'),
                ),
              ),
            ],
          ),
          title: Text(
            'USULAN PBPU BP PEMDA DARI DESA',
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
          children: const [getPending(), getDone()],
        ),
      ),
    );
  }
}
