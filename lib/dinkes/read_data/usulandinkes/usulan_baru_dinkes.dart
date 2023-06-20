import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginapp/shared/colors.dart';
import 'package:http/http.dart' as http;

class UsulanBaruDinkesPage extends StatefulWidget {
  const UsulanBaruDinkesPage({super.key});

  @override
  State<UsulanBaruDinkesPage> createState() => _UsulanBaruDinkesPageState();
}

class _UsulanBaruDinkesPageState extends State<UsulanBaruDinkesPage> {
  final _formState = GlobalKey<FormState>();
  TextEditingController namaFile = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController nik = TextEditingController();
  File? filePickerVal;
  bool isLoading = false;

  void selectFile() async {
    FilePickerResult? resultfile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (resultfile != null) {
      PlatformFile file = resultfile.files.first;

      int sizeInBytes = file.size;
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 5) {
        AwesomeDialog(
                dialogType: DialogType.error,
                body: Text('Berkas tidak boleh lebih dari 5 MB'),
                context: context)
            .show();
      } else {
        setState(() {
          namaFile.text = file.name;
          filePickerVal = File(resultfile.files.single.path.toString());

          print(file.name);
          print(file.size);
          print(file.extension);
          print(file.path);
        });
      }
    } else {}
  }

  Future usulData() async {
    try {
      setState(() {
        isLoading = true;
      });
      String usulUrl = "https://uhcdesa.jekaen-pky.com/api/add_usulan_dinkes";

      var response = http.MultipartRequest('POST', Uri.parse(usulUrl));

      response.fields['nik'] = nik.text;
      response.fields['nama'] = nama.text;
      response.files.add(http.MultipartFile('file',
          filePickerVal!.readAsBytes().asStream(), filePickerVal!.lengthSync(),
          filename: filePickerVal!.path.split("/").last));

      var res = await response.send();
      if (res.statusCode == 200) {
        Navigator.pop(context);
        return ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.success,
                title: "Berhasil!",
                text: "Usulan berhasil dikirim"));
      } else {
        return ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.warning,
                title: "Gagal!",
                text: "Usulan gagal dikirim, silahkan periksa kembali"));
      }
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    namaFile.dispose();
    nik.dispose();
    nama.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Text(
          'Tambah Usulan Baru',
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formState,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: nik,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 16,
                      validator: (value) {
                        if (value == '') {
                          return "NIK tidak boleh kosong";
                        }
                        if (value?.length != 16) {
                          return "NIK harus 16 digit";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('NIK'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: nama,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == '') {
                          return "Nama tidak boleh kosong";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Nama'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      enabled: false,
                      controller: namaFile,
                      validator: (value) {
                        if (value == '') {
                          return "File tidak boleh kosong";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Berkas",
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Palette.mainColor,
                    textColor: Colors.white,
                    onPressed: selectFile,
                    child: Text('Pilih File'),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Palette.mainColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            print(nama);
                            print(nik);
                            print(namaFile);
                            print("validasi");
                            usulData();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              body: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Periksa kembali usulan anda'),
                              ),
                            ).show();
                          }
                        },
                        child: Text('Usulkan'),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
