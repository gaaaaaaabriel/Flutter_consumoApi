import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/telaPrincipal.dart';

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return TelaPrincipal();
  }
}