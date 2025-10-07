import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/item_page.dart';

void main() {
  runApp(const BelanjaApp());
}

class BelanjaApp extends StatelessWidget {
  const BelanjaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Belanja',
      theme: ThemeData(primarySwatch: Colors.green),
      // initialRoute menunjukkan halaman pertama
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/item': (context) => const ItemPage(),
      },
    );
  }
}
