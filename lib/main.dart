// main.dart
import 'package:flutter/material.dart';
import 'package:enrollment_system/screens/login_page.dart';
import 'package:enrollment_system/screens/agregar_curso.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema Escolar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      
    );
  }
}
