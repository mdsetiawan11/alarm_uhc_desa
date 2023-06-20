import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:loginapp/desa/read_data/bnba/belum_terdaftar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getBelumTerdaftar extends StatefulWidget {
  const getBelumTerdaftar({super.key});

  @override
  State<getBelumTerdaftar> createState() => _getBelumTerdaftarState();
}

class _getBelumTerdaftarState extends State<getBelumTerdaftar> {
  String kddesa = '';

  List<Belum_Terdaftar> belums = [];

  Future getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    kddesa = (localStorage.getString('kddesa') ?? '');

    var url = Uri.parse(
        'https://uhcdesa.jekaen-pky.com/api/belum_terdaftar/' + kddesa);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachNonaktif in data) {
      final belumData = Belum_Terdaftar(
        nama: eachNonaktif['nama'],
      );

      belums.add(belumData);
    }
    print(belums.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: belums.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(belums[index].nama),
                  trailing: Text('BELUM TERDAFTAR'),
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
