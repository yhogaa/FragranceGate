import 'package:flutter/material.dart';
import 'package:inventory_flutter/models/fragrance_models.dart';
import 'package:inventory_flutter/widgets/left_drawer.dart';

class FragranceListPage extends StatelessWidget {
  final List<Fragrance> fragranceList; 

  const FragranceListPage({Key? key, required this.fragranceList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Parfum'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: ListView.builder(
        itemCount: fragranceList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: ListTile(
              title: Text(fragranceList[index].name),
              subtitle: Text('Jumlah: ${fragranceList[index].amount} | Harga: ${fragranceList[index].price}'),
              onTap: () {
                // Menampilkan popup dengan informasi barang yang di-klik
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(fragranceList[index].name),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Jumlah: ${fragranceList[index].amount}'),
                          Text('Harga: ${fragranceList[index].price}'),
                          Text('Deskripsi: ${fragranceList[index].description}'),
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
      ),
    );
  }
}
