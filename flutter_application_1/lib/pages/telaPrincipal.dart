import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/produtos_pages.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  TextEditingController pesquisaController = TextEditingController();

  bool digitar = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registros",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 25, 43),
      ),
      body: const Center(
        child: ProdutosPages(),
      ),
    );
  }
}
