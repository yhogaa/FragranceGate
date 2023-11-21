import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventory_flutter/models/fragrance_models.dart';
import 'package:inventory_flutter/screens/menu.dart';
import 'package:inventory_flutter/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

List<Fragrance> fragranceList = [];

class FragranceFormPage extends StatefulWidget {
    const FragranceFormPage({super.key});

    @override
    State<FragranceFormPage> createState() => _FragranceFormPageState();
}

class _FragranceFormPageState extends State<FragranceFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
    int _amount = 0;
    String _description = "";
    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Form Tambah Parfum',
              ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          drawer: const LeftDrawer(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Nama Parfum",
                        labelText: "Nama Parfum",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _name = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Nama tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Jumlah",
                        labelText: "Jumlah",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          _amount = int.parse(value!);
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Jumlah tidak boleh kosong!";
                        }
                        if (int.tryParse(value) == null) {
                          return "Jumlah harus berupa angka!";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Harga",
                        labelText: "Harga",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          _price = int.parse(value!);
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Harga tidak boleh kosong!";
                        }
                        if (int.tryParse(value) == null) {
                          return "Harga harus berupa angka!";
                        }
                        return null;
                      },
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Deskripsi",
                        labelText: "Deskripsi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _description = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Deskripsi tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.indigo),
                          ),
                          onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                  // Kirim ke Django dan tunggu respons
                                  // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                  final response = await request.postJson(
                                  "https://fadrian-yhoga-tugas.pbp.cs.ui.ac.id/create-flutter/",
                                  jsonEncode(<String, String>{
                                      'name': _name,
                                      'amount': _amount.toString(),
                                      'price': _price.toString(),
                                      'description': _description,
                                      // TODO: Sesuaikan field data sesuai dengan aplikasimu
                                  }));
                                  if (response['status'] == 'success') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                      content: Text("Parfum berhasil disimpan!"),
                                      ));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => MyHomePage()),
                                      );
                                  } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content:
                                              Text("Terdapat kesalahan, silakan coba lagi."),
                                      ));
                                  }
                              }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ]
              )
            ),
          ),
        );
    }
}