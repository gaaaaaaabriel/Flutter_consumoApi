import 'dart:convert';

import '../http/exeptions.dart';
import '../http/http_client.dart';
import '../models/produto_model.dart';

abstract class IProdutoReposity {
  Future<List<ProdutoModel>> getProduto();
}

class ProdutoRepositories implements IProdutoReposity {
  final IHttpClient client;

  ProdutoRepositories({required this.client});

  @override
  Future<List<ProdutoModel>> getProduto() async {
    final response = await client.get(url: "192.168.5.84/api_vazia/produtos");

    if (response.statusCode == 200) {
      final List<ProdutoModel> produtos = [];
      final body = jsonDecode(response);

      body['produtos'].map((item) {
        final ProdutoModel produto = ProdutoModel.fromMap(item);
        produtos.add(produto);
      }).toList();
      return produtos;
    } else if (response.statusCode == 404) {
      throw NotFoundExeption("a url informada não é valida");
    } else {
      throw Exception("Não foi possivel carregar os registros");
    }
  }
}
