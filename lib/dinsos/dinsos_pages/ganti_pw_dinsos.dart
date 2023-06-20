import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginapp/auth_pages/intro_screen.dart';
import 'package:loginapp/shared/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GantiPasswordDinsos extends StatefulWidget {
  const GantiPasswordDinsos({super.key});

  @override
  State<GantiPasswordDinsos> createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPasswordDinsos> {
  bool _passwordVisible = true;
  String username = '';
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _password.dispose();

    super.dispose();
  }

  getData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      username = (localStorage.getString('username') ?? '');
      print(username);
    });
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('level');
    localStorage.remove('intro');
    Navigator.pop(context);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext ctx) => IntroScreen()));
  }

  gantiPW() async {
    try {
      var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/gantipw/');
      var response = await http.put(
        url,
        body: {
          "username": username,
          "password": _password.text.trim(),
        },
      );
      var data = jsonDecode(response.body);
      if (data == "Password berhasil diubah") {
        Fluttertoast.showToast(
          msg: 'Password berhasil diubah.\n Silahkan login kembali',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        logout();
      } else {
        return Fluttertoast.showToast(
          msg: 'Password berhasil diubah, silahkan coba lagi',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      return Fluttertoast.showToast(
        msg: 'Password berhasil diubah, silahkan coba lagi',
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Ganti Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Palette.mainColor,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _password,
              decoration: InputDecoration(
                label: Text(
                  'Password Baru',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_passwordVisible,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: MaterialButton(
              onPressed: () {
                gantiPW();
              },
              color: Palette.mainColor,
              textColor: Colors.white,
              minWidth: double.infinity,
              child: Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
