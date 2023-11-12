# Fragrance Gate 🧴🌬️✨🌸

> **Fragrance Gate** adalah sebuah aplikasi mobile untuk mengelola penyimpanan *niche*, *designer*, *dupes*, atau bahkan lokal *perfume* anda.

### Daftar Tugas:
- **[Tugas 7](#tugas-7)**<br>
- **[Tugas 8](#tugas-8)**<br>

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
1. **MyHomePage**: Ini adalah widget utama yang merupakan halaman beranda dari aplikasi. Ini adalah widget Stateless (tidak memiliki keadaan internal) yang akan menggambarkan tampilan beranda aplikasi.

2. **Scaffold**: Ini adalah kerangka utama yang digunakan untuk menyusun berbagai elemen tampilan seperti AppBar dan body dalam satu tampilan. Ini memberikan kerangka umum untuk halaman.

3. **AppBar**: Widget ini digunakan untuk membuat bagian atas pada aplikasi yang berisi judul aplikasi dan tata letaknya.

4. **SingleChildScrollView**: Widget ini digunakan sebagai pembungkus untuk memungkinkan kontennya dapat discroll. Ini berguna ketika konten dalam halaman terlalu panjang untuk muat pada layar.

5. **Padding**: Widget ini digunakan untuk menambahkan jarak (padding) di sekitar widget-child yang ada di dalamnya.

6. **Column**: Widget ini digunakan untuk menampilkan widget-child secara vertikal. 

7. **Text**: Ini digunakan untuk menampilkan teks dalam aplikasi.

8. **GridView.count**: Ini adalah widget yang digunakan untuk menampilkan grid dengan jumlah kolom tetap. Dalam hal ini, grid ini digunakan untuk menampilkan daftar item toko.

9. **ShopCard**: Custom widget. Ini digunakan untuk menampilkan setiap item toko dalam bentuk card. Widget ini memiliki ikon dan teks, serta memberikan umpan balik saat ditekan.

10. **Material**: Ini adalah widget yang memberikan latar belakang berwarna pada setiap ShopCard.

11. **InkWell**: Ini adalah widget yang digunakan untuk membuat area yang responsif terhadap sentuhan. Ini digunakan untuk menangani interaksi saat pengguna mengklik ShopCard.

12. **Icon**: Ini digunakan untuk menampilkan ikon di dalam ShopCard.

13. **SnackBar**: Widget yang menampilkan pesan sementara yang muncul di bagian bawah layar ketika item di klik.

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

4. Untuk menampilkannya, pada `class MyHomePage` tambahkan kode berikut.
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

# Tugas 8
## `Navigator.push()` dan `Navigator.pushReplacement()`
`Navigator.push()` dan `Navigator.pushReplacement()` adalah dua metode yang berbeda dalam Flutter untuk menavigasi antara halaman. Berikut adalah perbedaan antara keduanya:

- `Navigator.push()` digunakan untuk menambahkan halaman baru ke dalam tumpukan halaman yang ada. Ketika pengguna menekan tombol kembali, halaman terakhir akan dihapus dari tumpukan dan pengguna akan kembali ke halaman sebelumnya. Contoh penggunaan: 

```dart
Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanBaru()));
```

- `Navigator.pushReplacement()` digunakan untuk mengganti halaman teratas dalam tumpukan halaman dengan halaman baru. Halaman sebelumnya akan dihapus dari tumpukan dan tidak dapat diakses lagi. Contoh penggunaan:

```dart
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HalamanBaru()));
```

Kedua metode ini dapat digunakan dalam berbagai skenario, tergantung pada kebutuhan aplikasi. Sebagai contoh, `Navigator.push()` dapat digunakan ketika pengguna ingin menavigasi ke halaman baru dan masih ingin dapat kembali ke halaman sebelumnya. Sedangkan `Navigator.pushReplacement()` dapat digunakan ketika pengguna menyelesaikan tugas tertentu dan tidak perlu kembali ke halaman sebelumnya.

Contoh penggunaan yang tepat dari kedua metode ini tergantung pada kebutuhan aplikasi. Sebagai contoh, `Navigator.push()` dapat digunakan ketika pengguna ingin menavigasi ke halaman detail dari daftar item, dan masih ingin dapat kembali ke halaman daftar item. Sedangkan `Navigator.pushReplacement()` dapat digunakan ketika pengguna menyelesaikan tugas seperti login dan tidak perlu kembali ke halaman login lagi. 
## *Layout* widget pada Flutter 

1. **Single-child layout widgets**
   - `Container`: Widget yang dapat digunakan untuk mengatur tampilan widget lainnya seperti padding, margin, dan background color.
   - `Center`: Widget yang digunakan untuk menempatkan widget lainnya di tengah-tengah layar.
   - `Align`: Widget yang digunakan untuk menempatkan widget lainnya pada posisi yang ditentukan.
   - `FractionallySizedBox`: Widget yang digunakan untuk menentukan ukuran widget anak sebagai fraksi dari ruang yang tersedia.
   - `AspectRatio`: Widget yang digunakan untuk menentukan rasio aspek widget anak.

2. **Multi-child layout widgets**
   - `Row` dan `Column`: Widget yang digunakan untuk menempatkan widget anak secara horizontal atau vertikal.
   - `Stack`: Widget yang digunakan untuk menumpuk widget anak di atas satu sama lain.
   - `IndexedStack`: Widget yang digunakan untuk menumpuk widget anak di atas satu sama lain, tetapi hanya menampilkan satu widget pada satu waktu.
   - `Flow`: Widget yang digunakan untuk menempatkan widget anak dalam bentuk aliran.
   - `Wrap`: Widget yang digunakan untuk menempatkan widget anak dalam bentuk wrapping.

3. **Sliver widgets**
   - `SliverAppBar`: Widget yang digunakan untuk menampilkan app bar yang dapat di-scroll.
   - `SliverList` dan `SliverGrid`: Widget yang digunakan untuk menampilkan daftar atau grid yang dapat di-scroll.
   - `SliverToBoxAdapter`: Widget yang digunakan untuk menempatkan widget lainnya di dalam `CustomScrollView` .

Konteks penggunaan masing-masing layout widget pada Flutter dapat bervariasi tergantung pada kebutuhan aplikasi yang dibangun. Sebagai contoh, `Row` dan `Column` dapat digunakan untuk menampilkan widget child secara horizontal atau vertikal, sedangkan `Stack` dapat digunakan untuk menumpuk widget child di atas satu sama lain. Selain itu, `SliverList` dan `SliverGrid` dapat digunakan untuk menampilkan daftar atau grid yang dapat di-scroll.

Untuk versi lengkap layout widget apa saja yang ada pada flutter bisa cek di [sini](https://docs.flutter.dev/ui/widgets/layout#Single-child%20layout%20widgets).
![widgettree](https://github.com/yhogaa/FragranceGate/assets/113284837/e3ca8b52-a808-44d2-9040-4d6e75fc98b2)
## Elemen input pada form
Pada tugas ini elemen input form yang saya gunakan hanya `TextFormField` dengan validasi input. Saya menggunakan `TextFormField` karena memungkinkan user untuk mengisi semua data sesuai keinginan dia sendiri. Saya juga menambahkan `inputFormatters` pada bagian input integer agar user hanya bisa memasukkan angka saja.
## *Clean architecture* pada aplikasi Flutter
Clean Architecture adalah sebuah konsep arsitektur perangkat lunak yang bertujuan untuk memisahkan kode untuk business-logic dengan kode yang berhubungan dengan platform seperti UI, state management, dan sumber data eksternal. Dalam konteks Flutter, clean architecture akan membantu kita untuk memisahkan kode untuk business-logic dengan kode yang berhubungan dengan platform seperti UI, state management, dan sumber data eksternal. Selain itu, kode yang kita tulis pun dapat lebih mudah untuk diuji (testable) secara independen.

Clean Architecture pada Flutter membagi project ke dalam 3 lapisan (layer) yaitu:
- Lapisan data & platform: Lapisan data terletak pada lapisan paling luar. Lapisan ini terdiri dari kode sumber data seperti Rest API, local database, Firebase, atau sumber lainnya. Juga kode platform yang membangun tampilan aplikasi (widgets).
- Lapisan presentation: Lapisan presentation terletak di tengah-tengah. Lapisan ini terdiri dari kode yang mengatur tampilan aplikasi (widgets) dan state management.
- Lapisan domain: Lapisan domain terletak pada lapisan paling dalam. Lapisan ini terdiri dari kode yang berisi business-logic aplikasi.

Dalam penerapannya, clean architecture pada Flutter dapat diimplementasikan dengan menggunakan konsep Test-Driven Development (TDD) dan Business Logic Components (BLoC) . Selain itu, dapat juga menggunakan library IoC container seperti Kiwi untuk melakukan dependency injection. Dalam membangun aplikasi berbasis mobile dengan Flutter, clean architecture akan sangat membantu untuk memudahkan pemeliharaan dan mengurangi risiko kerusakan yang tidak disengaja.
![1-TvhhRoAomLjG0gy0Jo8xA](https://github.com/yhogaa/FragranceGate/assets/113284837/9881f6ce-d5b2-41e0-a312-1e90271d9037)
![cleanarchitecture](https://github.com/yhogaa/FragranceGate/assets/113284837/00b311fe-6897-4c5b-bdda-2c7df0f91f01)
## **Implementasi Aplikasi**
* ## Membuat halaman input form untuk tambah item
1. Buat file baru pada direktori `lib` dengan nama `fragrancelist_form.dart` kemudian tambahkan code berikut.
```dart
import 'package:flutter/material.dart';

class FragranceFormPage extends StatefulWidget {
    const FragranceFormPage({super.key});

    @override
    State<FragranceFormPage> createState() => _FragranceFormPageState();
}

class _FragranceFormPageState extends State<FragranceFormPage> {

    @override
    Widget build(BuildContext context) {
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
          // TODO: Tambahkan drawer yang sudah dibuat di sini nanti
          body: Form(
            child: SingleChildScrollView(),
          ),
        );
    }
}
```
2. Buat variabel baru bernama `_formKey` lalu tambahkan `_formKey` tersebut ke dalam atribut `key` milik widget `Form`. Atribut key akan berfungsi sebagai handler dari form state, validasi form, dan penyimpanan form.
```dart
...
class _FragranceFormPageState extends State<FragranceFormPage> {
    final _formKey = GlobalKey<FormState>();
...
```
```dart
...
body: Form(
     key: _formKey,
     child: SingleChildScrollView(),
),
...
```
3. Buat variabel untuk menyimpan input dari masing-masing *field* yang akan dibuat.
```dart
...
class _FragranceFormPageState extends State<FragranceFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
    int _amount = 0;
    String _description = "";
...
```
4. Buat widget `Column` sebagai *child* dari `SingleChildScrollView`.
```dart
...
body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column()
      ),
...
```
5. Buatlah widget `TextFormField` yang dibungkus oleh `Padding` sebagai salah satu *children* dari widget `Column`. Setelah itu, tambahkan atribut `crossAxisAlignment` untuk mengatur alignment *children* dari Column.
```dart
...
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
...
```
> Ulangi langkah tersebut untuk setiap field yang dibutuhkan.

6. Untuk data bertipe integer, tambahkan `inputFormatters` berikut agar user hanya bisa menginput integer.
```dart
import 'package:flutter/services.dart';
...
keyboardType: TextInputType.number,
inputFormatters: <TextInputFormatter>[
  FilteringTextInputFormatter.digitsOnly,
],
onChanged: (String? value) {
  setState(() {
    _price = int.parse(value!);
  });
},
...
```

7. Buat tombol sebagai *child* selanjutnya dari `Column`. Bungkus tombol ke dalam widget `Padding` dan `Align`. Kita akan memunculkan `pop-up` yang akan muncul setelah tombol ditekan.
```dart
...
Align(
  alignment: Alignment.bottomCenter,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Colors.indigo),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
      },
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
),
...
```
* ## Mengarahkan user ke halaman form tambah parfum baru ketika menekan tombol `Tambah Parfum `pada halaman utama.
1. Pada `menu.dart` import halaman form yang telah dibuat sebelumnya.
```dart
import 'package:inventory_flutter/fragrancelist_form.dart';
```
2. Tambahkan kode  berikut di bawah kode `ScaffoldMessenger` untuk menambahkan navigasi ke halaman form.
```dart
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
},
```

* ## Memunculkan data dalam popup
1. Tambahkan fungsi `showDialog()` pada bagian `onPressed()` dan munculkan widget `AlertDialog` pada fungsi tersebut. Kemudian, tambahkan juga fungsi untuk *reset* form.
```dart
...
child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.indigo),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Parfum berhasil tersimpan'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text('Nama: $_name'),
                          Text('Jumlah: $_amount'),
                          Text('Harga: $_price'),
                          Text('Deskripsi: $_description'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            _formKey.currentState!.reset();
            }
          },
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
...
```

* ## Membuat drawer
1. Buatlah berkas baru di dalam direktori baru `widgets` dengan nama `left_drawer.dart` kemudian tambahkann kode berikut.
```dart
import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            // TODO: Bagian drawer header
          ),
          // TODO: Bagian routing
        ],
      ),
    );
  }
}
```
2. Tambahkan import untuk halaman-halaman yang ingin dimasukkan navigasinya ke dalam Drawer Menu.
```dart
import 'package:flutter/material.dart';
import 'package:inventory_flutter/screens/menu.dart';
import 'package:inventory_flutter/screens/fragrancelist_form.dart';
```
3. Setelah berhasil import, kita akan memasukkan routing untuk halaman-halaman yang kita impor ke bagian `TODO: Bagian routing`.
```dart
...
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Halaman Utama'),
  // Bagian redirection ke MyHomePage
  onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  },
),
ListTile(
leading: const Icon(Icons.add_shopping_cart),
title: const Text('Tambah Parfum'),
// Bagian redirection ke FragranceFormPage
onTap: () {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FragranceFormPage(),
      ));
  },
)
...
```
4. Selanjutnya, kita akan menghias drawer dengan memasukkan drawer header di `TODO: Bagian drawer header`.
```dart
const DrawerHeader(
  decoration: BoxDecoration(
    color: Colors.indigo,
  ),
  child: Column(
    children: [
      Text(
        'Fragrance Gate',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Padding(padding: EdgeInsets.all(10)),
        Text("Catat seluruh parfum yang kamu punya di sini!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
    ],
  ),
),
```

5. Drawer menu berhasil dibuat, Sekarang masukkan drawer ke halaman `menu.dart` dan `fragrancelist_form.dart`. 

- `menu.dart`
```dart
...
// Import drawer widget
import 'package:shopping_list/widgets/left_drawer.dart';
...
return Scaffold(
  appBar: AppBar(
    title: const Text(
      'FragranceGate',
    ),
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
  ),
  // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
  drawer: const LeftDrawer(),
...
```
- `fragrancelist_form.dart`
```dart
...
// Import drawer widget
import 'package:manageit_mobile/widgets/left_drawer.dart';
...
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
...
```