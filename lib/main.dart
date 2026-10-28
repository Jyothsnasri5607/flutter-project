import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CellPointApp());
}

class CellPointApp extends StatelessWidget {
  const CellPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cell Point',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const LoginScreen(),
    );
  }
}