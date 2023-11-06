# Fragrance Gate 🧴🌬️✨🌸

> **Fragrance Gate** adalah sebuah aplikasi mobile untuk mengelola penyimpanan *niche*, *designer*, *dupes*, atau bahkan lokal *perfume*.

### Daftar Tugas:
- **[Tugas 7](#tugas-7)**<br>

# Tugas 7
## **_Stateless_ dan _stateful widget_**
Stateless dan Stateful Widget adalah dua jenis widget yang umum digunakan dalam pengembangan aplikasi Flutter. Berikut adalah perbedaan utama antara Stateless dan Stateful Widget:

Stateless Widget:
- Widget yang di-build hanya dengan konfigurasi yang telah diinisiasi sejak awal.
- Widget yang tidak akan pernah berubah.
- Digunakan untuk membuat komponen yang statis dan tidak berubah.
- Tidak memiliki state internal yang dapat berubah seiring waktu.
- Tidak dapat menggunakan fungsi setState().

Stateful Widget:
- Widget yang dapat berubah dinamis.
- Digunakan untuk membuat komponen yang dapat berinteraksi atau merespons perubahan.
- Memiliki state internal yang dapat berubah seiring waktu.
- Dapat menggunakan fungsi setState() untuk memberitahu framework bahwa ada object yang berubah pada State, kemudian akan melakukan build ulang pada Widget tersebut.

Kesimpulannya, Stateless Widget digunakan untuk membuat komponen yang statis dan tidak berubah, sedangkan Stateful Widget digunakan untuk membuat komponen yang dapat berinteraksi atau merespons perubahan. Stateless Widget tidak memiliki state internal yang dapat berubah, sedangkan Stateful Widget memiliki state internal yang dapat berubah seiring waktu dan dapat menggunakan fungsi setState() untuk memberitahu framework bahwa ada object yang berubah pada State, kemudian akan melakukan build ulang pada Widget tersebut.

<img width="969" alt="SJURB" src="https://github.com/yhogaa/FragranceGate/assets/113284837/f76d4c23-398d-412e-a3bf-974c11e8f03a">

## **_Widget_ yang digunakan**
**MyHomePage**: Ini adalah widget utama yang merupakan halaman beranda dari aplikasi. Ini adalah widget Stateless (tidak memiliki keadaan internal) yang akan menggambarkan tampilan beranda aplikasi.

**Scaffold**: Ini adalah kerangka utama yang digunakan untuk menyusun berbagai elemen tampilan seperti AppBar dan body dalam satu tampilan. Ini memberikan kerangka umum untuk halaman.

**AppBar**: Widget ini digunakan untuk membuat bagian atas pada aplikasi yang berisi judul aplikasi dan tata letaknya.

**SingleChildScrollView**: Widget ini digunakan sebagai pembungkus untuk memungkinkan kontennya dapat discroll. Ini berguna ketika konten dalam halaman terlalu panjang untuk muat pada layar.

**Padding**: Widget ini digunakan untuk menambahkan jarak (padding) di sekitar widget-child yang ada di dalamnya.

**Column**: Widget ini digunakan untuk menampilkan widget-child secara vertikal. 

**Text**: Ini digunakan untuk menampilkan teks dalam aplikasi.

**GridView.count**: Ini adalah widget yang digunakan untuk menampilkan grid dengan jumlah kolom tetap. Dalam hal ini, grid ini digunakan untuk menampilkan daftar item toko.

**ShopCard**: Custom widget. Ini digunakan untuk menampilkan setiap item toko dalam bentuk card. Widget ini memiliki ikon dan teks, serta memberikan umpan balik saat ditekan.

**Material**: Ini adalah widget yang memberikan latar belakang berwarna pada setiap ShopCard.

**InkWell**: Ini adalah widget yang digunakan untuk membuat area yang responsif terhadap sentuhan. Ini digunakan untuk menangani interaksi saat pengguna mengklik ShopCard.

**Icon**: Ini digunakan untuk menampilkan ikon di dalam ShopCard.

**SnackBar**: Widget yang menampilkan pesan sementara yang muncul di bagian bawah layar ketika item di klik.

## **Implementasi Aplikasi**
* ## Membuat proyek flutter baru
1. Pastikan flutter sudah terinstall dan semua yang diperlukan sudah centang hijau. Buat direktori baru untuk menyimpan proyek flutter kemudian jalankan perintah berikut pada terminal untuk membuat proyek flutter baru dengnann nama `inventory_flutter`.
```
flutter create inventory_flutter
cd inventory_flutter
```
2. Jalankan proyek melalui terminal.
```
flutter run
```
Pilihlah angka 2 untuk mennjalankan proyek menggunakan Google Chrome.
* ## Merapikan struktur proyek
1. Buat file baru bernama `menu.dart` pada direktori `inventory_flutter/lib` dan tambahkan kode berikut.
```dart
import 'package:flutter/material.dart';
```
2. Dari file `main.dart` pindahkan `class MyHomePage { }` ke file `menu.dart` yang baru saja dibuat.
3. Hapus `class _MyHomePage State { } ` yang ada di `main.dart`
4. Tambahkan kode berikut pada `main.dart`
```dart
import 'package:inventory_flutter/menu.dart';
```
* ## Membuat widget sederhana
Pada `menu.dart` ubahlah sifat widget halaman dari stateful menjadi stateles. Lakukan perubahan seperti kode berikut.
```dart
class MyHomePage extends StatelessWidget  {
  MyHomePage({Key? key}) : super(key: key);
  ...
}
```
### Menambahkan Teks dan Card
1. Untuk menambahkan teks dan card, *define* tipe untuk list dalam class baru seperti berikut.
```dart
class FragranceItem {
    final String name;
    final IconData icon;

    FragranceItem(this.name, this.icon);
}
```
2. Tambahkan kode berikut dibawah `MyHomePage({Key? key}) : super(key: key);` untuk membuat tombol.
```dart
final List<FragranceItem> items = [
      FragranceItem("Lihat Parfum", Icons.checklist),
      FragranceItem("Tambah Parfum", Icons.add_shopping_cart),
      FragranceItem("Logout", Icons.logout),
  ];
```

3. Buatlah widget stateless baru untuk menampilkan card seperti berikut.
```dart
class FragranceCard extends StatelessWidget {
  final FragranceItem item;

  const FragranceCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
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
```

4. Untuk menampilkannya, pada `class MyHomePage` tambahkann kode berikut.
```dart
class MyHomePage extends StatelessWidget  {
  ...

   @override
    Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'FragranceGate',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Berikan Aroma Terbaikmu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((FragranceItem item) {
                  // Iterasi untuk setiap item
                  return FragranceCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
    } 
}
```
4. Proyek flutter sudah selesai, cek apakah tampilannya sudah berubah dengan menekan tombol `R` pada terminal ketika sudah di run.
