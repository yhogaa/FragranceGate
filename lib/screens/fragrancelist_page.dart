import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inventory_flutter/models/perfume.dart';
import 'package:inventory_flutter/screens/login.dart';
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
        'http://127.0.0.1:8000/json/');
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
            Perfume perfume = Perfume.fromJson(d);
            if(perfume.fields.user == loggedInUser?.id){
              list_Perfume.add(perfume);
            }
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
                if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return const Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                    Icons.warning,
                                    color: Color.fromARGB(255, 255, 0, 0),
                                    size: 50,
                                ),
                                SizedBox(height: 16),
                                Text(
                                    "Tidak ada data parfum.",
                                    style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Text(
                                    "Silakan tambahkan parfum dan nanti akan muncul disini.",
                                    style: TextStyle(color: Colors.grey, fontSize: 16),
                                    textAlign: TextAlign.center,
                                ),
                            ],
                        ),
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