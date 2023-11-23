import 'package:flutter/material.dart';
import 'package:inventory_flutter/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Provider(
          create: (_) {
              CookieRequest request = CookieRequest();
              return request;
          },
          child: MaterialApp(
              title: 'Fragrance Gate',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
                useMaterial3: true,
              ),
              home: const LoginPage(),
              routes: {
                    "/login": (BuildContext context) => const LoginPage(),
                },
              ),
          );
      }
}
