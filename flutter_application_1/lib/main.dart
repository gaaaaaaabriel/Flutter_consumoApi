
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/telaPrincipal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Aplicação',
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: const TelaPrincipal(),
    );
  }
}
