import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:loginapp/desa/read_data/bnba/nonaktif.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getNonaktif extends StatefulWidget {
  const getNonaktif({super.key});

  @override
  State<getNonaktif> createState() => _getNonaktifState();
}

class _getNonaktifState extends State<getNonaktif> {
  String kddesa = '';

  List<Nonaktif> nonaktifs = [];

  Future getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    kddesa = (localStorage.getString('kddesa') ?? '');

    var url =
        Uri.parse('https://uhcdesa.jekaen-pky.com/api/nonaktif/' + kddesa);
    var response = await http.get(url);
    var data = json.decode(response.body);

    for (var eachNonaktif in data) {
      final nonaktifData = Nonaktif(
          nama: eachNonaktif['nama'],
          segmen: eachNonaktif['segmen'],
          status_peserta: eachNonaktif['status_peserta']);
      nonaktifs.add(nonaktifData);
    }
    print(nonaktifs.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: nonaktifs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(nonaktifs[index].nama),
                  subtitle: Text(nonaktifs[index].segmen),
                  trailing: Text(nonaktifs[index].status_peserta.toUpperCase()),
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
