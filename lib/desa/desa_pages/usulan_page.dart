import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginapp/desa/read_data/usulan/get_pending.dart';
import 'package:loginapp/desa/read_data/usulan/get_done.dart';
import 'package:loginapp/desa/read_data/usulan/get_proses.dart';
import 'package:loginapp/desa/read_data/usulan/pending.dart';
import 'package:loginapp/desa/read_data/usulan/proses.dart';
import 'package:loginapp/desa/read_data/usulan/selesai.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UsulanPage extends StatefulWidget {
  const UsulanPage({super.key});

  @override
  State<UsulanPage> createState() => _UsulanPageState();
}

class _UsulanPageState extends State<UsulanPage> {
  List<Pending> allpending = [];
  List<Proses> allproses = [];
  List<Selesai> alldone = [];

  getJumlahSelesai() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String kddesa = (localStorage.getString('kddesa') ?? '');
    var url = Uri.parse(
        'https://uhcdesa.jekaen-pky.com/api/usulandesaselesai/' + kddesa);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachDone in data) {
      final doneData = Selesai(
          id: eachDone['id'],
          nik: eachDone['nik'],
          nama: eachDone['nama'],
          status: eachDone['status'],
          file: eachDone['file'],
          keterangan: eachDone['keterangan']);
      alldone.add(doneData);
    }
    setState(() {
      alldone.length;
    });
  }

  getJumlahProses() async {
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
      allproses.add(pendingData);
    }
    setState(() {
      allproses.length;
    });
  }

  getJumlahPending() async {
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
    setState(() {
      allpending.length;
    });
  }

  @override
  void initState() {
    getJumlahPending();
    getJumlahProses();
    getJumlahSelesai();
    super.initState();
  }

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
                icon: badges.Badge(
                  showBadge: allpending.length > 0 ? true : false,
                  position: badges.BadgePosition.topEnd(top: -20, end: -20),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                  badgeContent: Text(
                    allpending.length.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                  child: Text('Pending'),
                ),
              ),
              Tab(
                icon: badges.Badge(
                  showBadge: allproses.length > 0 ? true : false,
                  position: badges.BadgePosition.topEnd(top: -20, end: -20),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                  badgeContent: Text(
                    allproses.length.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                  child: Text('Proses'),
                ),
              ),
              Tab(
                icon: badges.Badge(
                  showBadge: alldone.length > 0 ? true : false,
                  position: badges.BadgePosition.topEnd(top: -20, end: -20),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                  badgeContent: Text(
                    alldone.length.toString(),
                    style: TextStyle(fontSize: 10),
                  ),
                  child: Text('Selesai'),
                ),
              ),
            ],
          ),
          title: Text(
            'Usulan PBPU BP Pemda',
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
          children: const [getPending(), getProses(), getDone()],
        ),
      ),
    );
  }
}
