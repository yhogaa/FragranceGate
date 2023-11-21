import 'package:flutter/material.dart';
import 'package:inventory_flutter/screens/fragrancelist_form.dart';
import 'package:inventory_flutter/screens/fragrancelist_page.dart';
import 'package:inventory_flutter/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    final request = context.watch<CookieRequest>();
    return Material(
      color: item.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
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

          else if (item.name == "Lihat Parfum") {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PerfumePage()));
          } 

          else if (item.name == "Logout") {
                final response = await request.logout(
                    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                    "http://127.0.0.1:8000/auth/logout/");
                String message = response["message"];
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message"),
                  ));
                }
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