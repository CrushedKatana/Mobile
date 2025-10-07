import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/item_page.dart';

void main() {
  runApp(const PlushieApp());
}

class PlushieApp extends StatelessWidget {
  const PlushieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plushie Collection',
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/item': (context) => const ItemPage(),
      },
    );
  }
}
