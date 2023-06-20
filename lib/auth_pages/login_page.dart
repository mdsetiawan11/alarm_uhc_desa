// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginapp/dinkes/dinkes_pages/home_dinkes.dart';
import 'package:loginapp/dinsos/dinsos_pages/home_dinsos.dart';

import 'package:loginapp/shared/colors.dart';
import 'package:http/http.dart' as http;
import 'package:loginapp/desa/desa_pages/home_desa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPagebaseState();
}

class _LoginPagebaseState extends State<LoginPage> {
  bool _passwordVisible = true;
  bool isLoading = false;
  //textController
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future login() async {
    try {
      var url = Uri.parse('https://uhcdesa.jekaen-pky.com/api/login');
      var response = await http.post(
        url,
        body: {
          "username": _username.text.trim(),
          "password": _password.text.trim(),
        },
      );
      var data = jsonDecode(response.body);
      print(data);
      if (data == "Username atau Password salah.") {
        return Fluttertoast.showToast(
          msg: 'Username atau password salah',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        final localStorage = await SharedPreferences.getInstance();
        await localStorage.setString("nama", data['nama']);
        await localStorage.setString("kddesa", data['username']);
        await localStorage.setString("username", data['username']);
        await localStorage.setString("level", data['level']);
        await localStorage.setString("dati2", data['dati2']);
        await localStorage.setString("intro", "sudah");

        if (data['level'] == '2') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeDesa()));
        } else if (data['level'] == '3') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeDinsos()));
        } else if (data['level'] == '4') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeDinkes()));
        }
        Fluttertoast.showToast(
          msg: 'Selamat datang di Alarm UHC Desa',
          backgroundColor: Colors.green.shade800,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      return Fluttertoast.showToast(
        msg: 'Username atau password salah',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: SvgPicture.asset('lib/images/logo.svg')),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      label: Text('Username'),
                      icon: Icon(
                        Icons.person,
                        color: Palette.mainColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      icon: Icon(
                        Icons.key,
                        color: Palette.mainColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
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
                  height: 35,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Palette.mainColor,
                        textColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });

                          Future.delayed(Duration(seconds: 2), () {
                            login();
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

//email
}
