import 'package:flutter/material.dart';

import 'widget/home_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
