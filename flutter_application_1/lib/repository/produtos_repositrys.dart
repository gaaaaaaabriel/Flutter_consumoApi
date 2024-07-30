import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/produto.dart';
import 'package:flutter/material.dart';

class ProdutosRepositrys {
  final String baseUrl = "http://192.168.5.84/api_vazia/produtos";

  Future<List<Produto>> buscarRegistros() async {
    var response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;

      return json.map((dados) => Produto.fromNuvem(dados)).toList();
    } else {
      return [];
    }
  }

  Future<bool> excluirRegistros(int id) async {
    String url = "$baseUrl/$id";

    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Erro ao excluir produto: ${response.body}');
      return false;
    }
  }

  Future<bool> atualizarRegistro(int id, String nome, String email) async {
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
        return true;
      } else {
        debugPrint('Erro ao atualizar produto: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Ocorreu um erro: $e');
      return false;
    }
  }

  Future<bool> adicionarRegistro(String nome, String email) async {
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
      debugPrint('Registro adicionado com sucesso.');
      return true;
    } else {
      debugPrint('Erro ao adicionar registro: ${response.body}');
      return false;
    }
  }
}
