import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inventory_flutter/models/perfume.dart';
import 'package:inventory_flutter/widgets/left_drawer.dart';

class PerfumePage extends StatefulWidget {
    const PerfumePage({Key? key}) : super(key: key);

    @override
    _PerfumePageState createState() => _PerfumePageState();
}

class _PerfumePageState extends State<PerfumePage> {
Future<List<Perfume>> fetchPerfume() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'https://fadrian-yhoga-tugas.pbp.cs.ui.ac.id/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Perfume
    List<Perfume> list_Perfume = [];
    for (var d in data) {
        if (d != null) {
            list_Perfume.add(Perfume.fromJson(d));
        }
    }
    return list_Perfume;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Perfume'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchPerfume(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: ListTile(
                            title: Text("${snapshot.data![index].fields.name}"),
                            subtitle: Text('Jumlah: ${snapshot.data![index].fields.amount} | Harga: ${snapshot.data![index].fields.price}'),
                            onTap: () {
                              // Menampilkan popup dengan informasi barang yang di-klik
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("${snapshot.data![index].fields.name}"),
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Jumlah: ${snapshot.data![index].fields.amount}'),
                                        Text('Harga: ${snapshot.data![index].fields.price}'),
                                        Text('Deskripsi: ${snapshot.data![index].fields.description}'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Tutup'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                    }
                }
            }));
    }
}