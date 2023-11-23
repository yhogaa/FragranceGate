# Fragrance Gate 🧴🌬️✨🌸

> **Fragrance Gate** adalah sebuah aplikasi mobile untuk mengelola penyimpanan *niche*, *designer*, *dupes*, atau bahkan lokal *perfume* anda.

### Daftar Tugas:
- **[Tugas 9](#tugas-9)**<br>

# Tugas 9
## **Pengambilan data JSON**
**Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu?** Jawabannya bisa, kita bisa melakukan pengambilan data JSON tanpa membuat model terlebih dahulu. Namun, apakah hal tersebut lebih baik daripada membuat model terlebih dahulu tergantung pada kebutuhan dan kompleksitas data yang akan diambil. Jika data yang diambil sederhana dan tidak memerlukan banyak manipulasi, maka pengambilan data JSON tanpa membuat model terlebih dahulu dapat dilakukan. Namun, jika data yang diambil kompleks dan memerlukan banyak manipulasi, maka lebih baik membuat model terlebih dahulu agar memudahkan pengambilan dan manipulasi data.
## **`CookieRequest`**
CookieRequest adalah sebuah instance yang digunakan untuk mengambil cookie dari sebuah request pada aplikasi Flutter. Fungsi dari CookieRequest adalah untuk melakukan permintaan HTTP yang menyertakan cookie, Menyediakan fungsi untuk inisialisasi sesi, login, dan logout ,  dll. Instance CookieRequest perlu dibagikan ke semua komponen di aplikasi Flutter agar dapat digunakan secara global pada seluruh komponen. Dengan begitu, kita dapat mengakses cookie yang sama pada seluruh komponen aplikasi tanpa perlu membuat instance baru setiap kali ingin mengambil cookie.
## **Mekanisme Pengambilan Data JSON**
1. Membuat model kustom, gunakan website [Quicktype](https://app.quicktype.io/) untuk membuat data JSON yang didapat dari endpoint `/json` pada tugas Django.
2. Menambahkan dependensi HTTP dengan pada file `android/app/src/main/AndroidManifest.xml` tambahkan code berikut
```xml
<application>
    ...
    </application>
    <!-- Required to fetch data from the Internet. -->
    <uses-permission android:name="android.permission.INTERNET" />
    ...
```
3. Lakukan fetch data dengan mengimplementasi fungsi asinkrosnus dan mengirim HTTP pada file yang ingin melakukan fetch, contohnya seperti code berikut.
```dart
Future<List<Perfume>> fetchPerfume() async {
    var url = Uri.parse(
        'https://fadrian-yhoga-tugas.pbp.cs.ui.ac.id/get-item/');
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
```

## **Mekanisme autentikasi**
1. Username memasuki page login (`LoginPage`)dan memasukkan data `username` dan `password` 
2. Tombol login ditekan dan fungsi login pada `CookieRequest` dipanggl yang mengrimklan HTTP request dentgan ednpoint URL proyek djangoi
3. Dilakukan autentikasi pada django `user = authenticate(username=username, password=password)` di `views.py` milik `authentication`
4. Setelah itui cek apakah user sudah pernah dibuat atau belum.
5. Pada Flutter, jika `request.loggedIn`, pengguna diarahkan ke `MyHomePage` dan muncul tampilan selamat datang menggunakan `SnackBar`.

## **Widget yang Digunakan**
1. **FutureBuilder**: Widget ini digunakan untuk membuat widget berdasarkan hasil terakhir yang dihitung oleh Future. Dalam kode ini, FutureBuilder digunakan untuk membangun UI berdasarkan hasil dari `fetchPerfume()`.

2. **ListView.builder**: Widget ini digunakan untuk membuat daftar item yang dapat digulir. Dalam kode ini, ListView.builder digunakan untuk menampilkan daftar perfume.

3. **Card**: Widget ini digunakan untuk menampilkan informasi terkait dalam blok berbentuk persegi panjang. Dalam kode ini, Card digunakan untuk menampilkan informasi tentang setiap perfume.

4. **ListTile**: Widget ini digunakan untuk menampilkan hingga 3 baris teks dan ikon yang opsional di awal dan akhir. Dalam kode ini, ListTile digunakan untuk menampilkan nama dan detail perfume.

5. **AlertDialog**: Widget ini digunakan untuk menampilkan dialog material design. Dalam kode ini, AlertDialog digunakan untuk menampilkan informasi detail tentang perfume yang dipilih.

6. **TextButton**: Widget ini digunakan untuk menampilkan tombol dengan teks. Dalam kode ini, TextButton digunakan untuk menutup AlertDialog.

## **Implementasi Aplikasi**
* ## Deployment Django
Mengubah models pada proyek django dan melakukan re-deploy.

## Login Page
1. Membuat `django-app` bernama `authentication` pada project Django
2. Tambahkan `authentication` ke `INSTALLED_APPS` pada main project `settings.py` aplikasi Django.

3. Jalankan perintah `pip install django-cors-headers` untuk menginstal library yang dibutuhkan.

4. Tambahkan `corsheaders` ke `INSTALLED_APPS` pada main project `settings.py` aplikasi Django.

5. Tambahkan `corsheaders.middleware.CorsMiddleware` pada main project `settings.py` aplikasi Django.
6. Tambahkan beberapa variabel berikut ini pada main project `settings.py` aplikasi Django.
``` python
CORS_ALLOW_ALL_ORIGINS = True
CORS_ALLOW_CREDENTIALS = True
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SAMESITE = 'None'
SESSION_COOKIE_SAMESITE = 'None'
```

7. Buat sebuah metode view untuk `login` pada `authentication/views.py`.
``` python
from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!"
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)
```

8. Buat file `urls.py` pada folder `authentication` dan tambahkan URL routing terhadap fungsi yang sudah dibuat dengan endpoint `login/`.
``` python
from django.urls import path
from authentication.views import login

app_name = 'authentication'

urlpatterns = [
    path('login/', login, name='login'),
]
```

9. Terakhir, tambahkan `path('auth/', include('authentication.urls'))`, pada file `inventory_assignments/urls.py`.

## Integrasi Sistem Autentikasi pada Flutter
1. Instal package yang telah disediakan oleh tim asisten dosen dengan menjalankan perintah berikut di Terminal.
```
flutter pub add provider
flutter pub add pbp_django_auth
```

Untuk menggunakan package tersebut, kamu perlu memodifikasi root widget untuk menyediakan CookieRequest library ke semua child widgets dengan menggunakan Provider.

2. Modifikasi root widget untuk menyediakan CookieRequest library ke semua child widgets dengan menggunakan Provider. Hal ini akan membuat objek Provider baru yang akan membagikan instance CookieRequest dengan semua komponen yang ada di aplikasi.

3. Membuat file baru pada folder `screens` dengan nama `login.dart`.

4. Isilah file `login.dart` dengan kode untuk menjalankan fungsi dan tampilan login seperti berikut.
```dart
import 'package:inventory_flutter/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:inventory_flutter/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
    runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
const LoginApp({super.key});

@override
Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        theme: ThemeData(
            primarySwatch: Colors.blue,
    ),
    home: const LoginPage(),
    );
    }
}

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: const Text('Login'),
            ),
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                            ),
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                            ),
                            obscureText: true,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                            onPressed: () async {
                                String username = _usernameController.text;
                                String password = _passwordController.text;

                                final response = await request.login("https://fadrian-yhoga-tugas.pbp.cs.ui.ac.id/auth/login/", {
                                'username': username,
                                'password': password,
                                });
                    
                                if (request.loggedIn) {
                                    String message = response['message'];
                                    String uname = response['username'];
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                            SnackBar(content: Text("$message Selamat datang, $uname.")));
                                    } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: const Text('Login Gagal'),
                                            content:
                                                Text(response['message']),
                                            actions: [
                                                TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                        Navigator.pop(context);
                                                    },
                                                ),
                                            ],
                                        ),
                                    );
                                }
                            },
                            child: const Text('Login'),
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                            onPressed: () async {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                                );
                            },
                            child: const Text('Register'),
                            )
                    ],
                ),
            ),
        );
    }
}
```

5. Pada file `main.dart`, pada Widget `MaterialApp(...)`, ubah `home: MyHomePage()` menjadi `home: LoginPage()`

## Pembuatan Model Kustom

1. Buka endpoint JSON yang sudah dibuat sebelumnya pada tutorial 2.

2. Salin data JSON dan buka situs web [Quicktype](https://app.quicktype.io/).

3. Pada situs web Quicktype, ubahlah setup name menjadi `Item`, source type menjadi `JSON`, dan language menjadi `Dart`.

4. Tempel data JSON yang telah disalin sebelumnya ke dalam textbox yang tersedia pada Quicktype.

5. Klik pilihan Copy Code pada Quicktype.

6. Buka kembali proyek Flutter, buat file baru pada folder `lib/models` dengan nama `perfume.dart`, dan tempel kode yang sudah disalin dari Quicktype

## Halaman yang berisi daftar semua item
### Menambahkan dependensi HTTP
1. lakukan `flutter add pub http` pada terminmal
2. Pada file `android/app/src/main/AndroidManifest.xml`, tambahkan kode berikut untuk memperbolehkan akses Internet pada aplikasi Flutter yang sedang dibuat.
``` xml
...
    <application>
    ...
    </application>
    <!-- Required to fetch data from the Internet. -->
    <uses-permission android:name="android.permission.INTERNET" />
...
```
### Fetch dari Django
1. Buat file baru pada folder `lib/screens` dengan nama `fragrancelist_page.dart`
2. Pada file `fragrancelist_page.dart`, impor library yang dibutuhkan.
``` dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inventory_flutter/models/perfume.dart';
import 'package:inventory_flutter/widgets/left_drawer.dart';
...
```
3. Buat stateful widget untuk melakukan fetch data dari django 
4. Tambahkan halaman `fragrancelist_page.dart` ke `widgets/left_drawer.dart`.
5. Ubah fungsi tombol `Lihat Produk` pada halaman utama agar mengarahkan ke halaman `PerfumePage` dengan menambahkan else if setelah kode if(...){...} di bagian akhir `onTap: () { }` yang ada pada file `widgets/fragrance_card.dart`
6. Impor file yang dibutuhkan saat menambahkan `PerfumePage` ke `left_drawer.dart` dan `fragrance_card.dart`

