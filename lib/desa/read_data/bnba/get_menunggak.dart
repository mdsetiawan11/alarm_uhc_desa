import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:loginapp/desa/read_data/bnba/menunggak.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getMenunggak extends StatefulWidget {
  const getMenunggak({super.key});

  @override
  State<getMenunggak> createState() => _getMenunggakState();
}

class _getMenunggakState extends State<getMenunggak> {
  String kddesa = '';

  List<Menunggak> menunggaks = [];

  Future getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    kddesa = (localStorage.getString('kddesa') ?? '');

    var url =
        Uri.parse('https://uhcdesa.jekaen-pky.com/api/menunggak/' + kddesa);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachNonaktif in data) {
      final nmenunggakData = Menunggak(
          nama: eachNonaktif['nama'],
          segmen: eachNonaktif['segmen'],
          status_peserta: eachNonaktif['status_peserta']);
      menunggaks.add(nmenunggakData);
    }
    print(menunggaks.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: menunggaks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(menunggaks[index].nama),
                  subtitle: Text(menunggaks[index].segmen),
                  trailing:
                      Text(menunggaks[index].status_peserta.toUpperCase()),
                );
              },
            );
          } else {
            return Center(
                child: LoadingAnimationWidget.inkDrop(
                    color: Palette.mainColor, size: 30));
          }
        });
  }
}
