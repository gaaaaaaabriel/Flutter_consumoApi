import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/atlualizar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/pages/alert_Nome_email.dart';

class ProdutosPages extends StatefulWidget {
  const ProdutosPages({super.key});

  @override
  State<ProdutosPages> createState() => _ProdutosPagesState();
}

class _ProdutosPagesState extends State<ProdutosPages> {
//função para adicionar novos registros no meu banco de dados
  Future<void> adicionarRegistro(String nome, String email) async {
    String url = "http://192.168.5.84/api_vazia/produtos";

    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'nome': nome,
          'email': email,
        },
      ),
    );

    if (response.statusCode == 200) {
      // Registro adicionado com sucesso
      debugPrint('Registro adicionado com sucesso.');
    } else {
      debugPrint('Erro ao adicionar registro: ${response.body}');
    }
  }

  void _showAddProductDialog() {
    EditarRegistroDialog(
      nomePri: 'Adicionar Registros',
      buttonFunc: 'Adicionar',
      context: context,
      nomeAtual: "",
      emailAtual: "",
      onSalvar: (String nome, String email) async {
        if (nome.trim().isNotEmpty && email.trim().isNotEmpty) {
          await adicionarRegistro(nome, email);
          setState(() {});
        } else {
          debugPrint("ira retornar um popup de erros");
        }
      },
    ).mostrarDialog();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BUILDOU AQUI");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registros"),
      ),
      body: AlertNomeEmail(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        backgroundColor: const Color.fromARGB(255, 0, 25, 43),
        child: const Icon(
          Icons.add,
          color: Colors.pink,
        ),
      ),
    );
  }
}
