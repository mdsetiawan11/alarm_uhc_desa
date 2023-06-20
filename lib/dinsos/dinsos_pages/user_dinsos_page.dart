import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/auth_pages/intro_screen.dart';
import 'package:loginapp/dinsos/dinsos_pages/ganti_pw_dinsos.dart';

import 'package:loginapp/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDinsosPage extends StatefulWidget {
  const UserDinsosPage({super.key});

  @override
  State<UserDinsosPage> createState() => _UserDinsosPageState();
}

class _UserDinsosPageState extends State<UserDinsosPage> {
  String nama = '';

  //logout
  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('level');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => IntroScreen()));
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      nama = (localStorage.getString('nama') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: (() {
                print('Info');
                AwesomeDialog(
                  context: context,
                  customHeader: Image(
                    image: AssetImage('lib/images/coding.png'),
                    width: 80,
                    height: 80,
                  ),
                  animType: AnimType.scale,
                  desc: 'based on flutter develop by mdsdev',
                )..show();
              }),
              child: Icon(Icons.perm_device_information),
            ),
          ),
        ],
        title: Text(
          'PROFIL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Palette.mainColor,
                borderRadius: BorderRadius.circular(20)),
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    child: Image(
                      image: AssetImage('lib/images/user.png'),
                      height: 100,
                      width: 100,
                    ),
                    radius: 70,
                    backgroundColor: Colors.white,
                  ),
                  Container(
                    child: Text(
                      nama.toUpperCase(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child: Card(
              shape: Border.all(color: Palette.mainColor),
              elevation: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MaterialButton(
                      highlightColor: Colors.blueAccent.shade100,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GantiPasswordDinsos()));
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.password,
                          color: Palette.mainColor,
                        ),
                        title: Text(
                          'Ganti Password',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        shape: Border(
                          bottom: BorderSide(color: Palette.mainColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MaterialButton(
                      highlightColor: Colors.blueAccent.shade100,
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.noHeader,
                          animType: AnimType.scale,
                          title: 'Logout',
                          desc: 'Apakah anda yakin ingin logout?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () {
                            logout();
                          },
                        )..show();
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Palette.mainColor,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        shape: Border(
                          bottom: BorderSide(color: Palette.mainColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Versi 1.0.0',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
