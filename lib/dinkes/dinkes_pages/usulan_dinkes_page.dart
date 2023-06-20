import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginapp/dinkes/read_data/usulandinkes/done.dart';
import 'package:loginapp/dinkes/read_data/usulandinkes/get_done.dart';
import 'package:loginapp/dinkes/read_data/usulandinkes/get_pending.dart';
import 'package:loginapp/dinkes/read_data/usulandinkes/pending.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;

class UsulanDinkesPage extends StatefulWidget {
  const UsulanDinkesPage({super.key});

  @override
  State<UsulanDinkesPage> createState() => _UsulanDinkesPageState();
}

class _UsulanDinkesPageState extends State<UsulanDinkesPage> {
  List<Pending> allpending = [];
  List<Done> alldone = [];

  getJumlahUsulanDinkesPending() async {
    var url =
        Uri.parse('https://uhcdesa.jekaen-pky.com/api/usulandinkespending/');
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachPending in data) {
      final pendingData = Pending(
          id: eachPending['id'],
          tahun: eachPending['tahun'],
          bulan: eachPending['bulan'],
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

  getJumlahUsulanDinkesDone() async {
    var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/usulandinkesdone/');
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachDone in data) {
      final doneData = Done(
          id: eachDone['id'],
          tahun: eachDone['tahun'],
          bulan: eachDone['bulan'],
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

  @override
  void initState() {
    getJumlahUsulanDinkesPending();
    getJumlahUsulanDinkesDone();
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
            'USULAN PBPU BP PEMDA',
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
