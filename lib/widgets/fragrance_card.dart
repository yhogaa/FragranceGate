import 'package:flutter/material.dart';
import 'package:inventory_flutter/screens/fragrancelist_form.dart';
import 'package:inventory_flutter/screens/fragrancelist_page.dart';

class FragranceItem {
    final String name;
    final IconData icon;
    final Color color;

    FragranceItem(this.name, this.icon, this.color);
}

class FragranceCard extends StatelessWidget {
  final FragranceItem item;

  const FragranceCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // Navigate ke route yang sesuai (tergantung jenis tombol)
          if (item.name == "Tambah Parfum") {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FragranceFormPage()));
          }

          if (item.name == "Lihat Parfum") {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => FragranceListPage(fragranceList: fragranceList)));
          }
        
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}