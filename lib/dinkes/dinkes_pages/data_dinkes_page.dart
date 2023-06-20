import 'package:flutter/material.dart';
import 'package:loginapp/dinkes/read_data/uhckecdesa/get_desa.dart';
import 'package:loginapp/dinkes/read_data/uhckecdesa/get_kecamatan.dart';
import 'package:loginapp/shared/colors.dart';

class DataDinkesPage extends StatefulWidget {
  const DataDinkesPage({super.key});

  @override
  State<DataDinkesPage> createState() => _DataDinkesPageState();
}

class _DataDinkesPageState extends State<DataDinkesPage> {
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
                text: 'UHC Kecamatan',
              ),
              Tab(
                text: 'UHC Desa',
              ),
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
          children: const [getKecamatan(), getDesa()],
        ),
      ),
    );
  }
}
