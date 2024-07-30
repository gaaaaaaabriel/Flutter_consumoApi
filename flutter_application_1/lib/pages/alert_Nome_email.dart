import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/produto.dart';
import 'package:flutter_application_1/utils/atlualizar.dart';
import 'package:http/http.dart' as http;

class AlertNomeEmail extends StatefulWidget {
  final List<Produto> produtos;
  const AlertNomeEmail({super.key, required this.produtos});

  @override
  State<AlertNomeEmail> createState() => _AlertNomeEmailState();
}

class _AlertNomeEmailState extends State<AlertNomeEmail> {
  // Método para buscar todos os registros do banco de dados
  Future<List<Produto>> buscarRegistros() async {
    String url = "http://192.168.5.84/api_vazia/produtos";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      List<Produto> produtos = [];
      for (var dados in json) {
        Produto produto = Produto.fromNuvem(dados);
        produtos.add(produto);
      }
      return produtos;
    } else {
      debugPrint(response.body);
    }

    return [];
  }

  // Método para excluir dados do banco de dados
  Future<bool> excluirRegistros(int id) async {
    String url = "http://192.168.5.84/api_vazia/produtos/$id";

    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Erro ao excluir produto: ${response.body}');
      return false;
    }
  }

  // Método para atualizar registros do banco de dados

  Future<void> atualizarRegistro(int id, String nome, String email) async {
    String baseUrl = "http://192.168.5.84/api_vazia/produtos";
    String url = "$baseUrl/$id";

    try {
      var response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'nome': nome,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Produto atualizado com sucesso!');
      } else {
        debugPrint('Erro ao atualizar produto: ${response.body}');
      }
    } catch (e) {
      debugPrint('Ocorreu um erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // FutureBuilder está esperando uma lista de registros do meu banco de dados
    return FutureBuilder<List<Produto>>(
      future: buscarRegistros(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && !snapshot.hasError) {
          var registros = snapshot.data!;

          return ListView.builder(
            itemCount: registros.length,
            itemBuilder: (context, index) {
              var registro = registros[index];
              return ListTile(
                title: Text(registro.nome),
                subtitle: Text(registro.email),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Detalhes do registro",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Nome: ${registro.nome}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Email: ${registro.email}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () {
                                  EditarRegistroDialog(
                                    nomePri: 'Editar Registros',
                                    buttonFunc: 'Salvar',
                                    context: context,
                                    nomeAtual: registro.nome,
                                    emailAtual: registro.email,
                                    onSalvar: (nome, email) async {
                                      await atualizarRegistro(
                                          registro.id, nome, email);
                                      setState(() {
                                        // Atualiza a lista de registros
                                        Navigator.of(context).pop();
                                      });
                                    },
                                  ).mostrarDialog();
                                },
                                child: const Text(
                                  "Editar",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await excluirRegistros(registro.id);
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Icon(
                                  Icons.auto_delete,
                                  color: Colors.pink,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                        backgroundColor: const Color.fromARGB(255, 0, 25, 43),
                      );
                    },
                  );
                },
              );
            },
          );
        } else {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }
      },
    );
  }
}
