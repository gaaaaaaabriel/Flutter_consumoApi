import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/produto.dart';
import 'package:flutter_application_1/repository/produtos_repositrys.dart';
import 'package:flutter_application_1/utils/atlualizar.dart';

class ProdutosController extends ChangeNotifier {
  //variavel
  final ProdutosRepositrys crud = ProdutosRepositrys();
  List<Produto> produtos = [];
  List<Produto> produtosFiltrados = [];
  late BuildContext context;
  late Future<void> buscarRegistro;

  //Funções
  Future<void> buscarRegistros2() async {
    produtos = await crud.buscarRegistros();
    produtosFiltrados = produtos;
    notifyListeners();
  }

  Future<void> excluirRegistros2(int id) async {
    bool sucesso = await crud.excluirRegistros(id);
    if (sucesso) {
      await buscarRegistros2();
    }
  }

  Future<void> atualizarRegistro2(int id, String nome, String email) async {
    bool sucesso = await crud.atualizarRegistro(id, nome, email);
    if (sucesso) {
      await buscarRegistros2();
    }
  }

  Future<void> adicionarRegistros2(String nome, String email) async {
    bool sucesso = await crud.adicionarRegistro(nome, email);
    if (sucesso) {
      await buscarRegistros2();
    }
  }

  void filtrarRegistros(String pesquisa) {
    debugPrint("AQUI");
    produtosFiltrados = produtos.where((produto) {
      return produto.nome.toLowerCase().contains(pesquisa) ||
          produto.email.toLowerCase().contains(pesquisa);
    }).toList();
    notifyListeners();
  }

  //PopUp
  void showAddProductDialog() {
    EditarRegistroDialog(
      nomePri: 'Adicionar Registros',
      buttonFunc: 'Adicionar',
      context: context,
      nomeAtual: "",
      emailAtual: "",
      onSalvar: (String nome, String email) async {
        if (nome.trim().isNotEmpty && email.trim().isNotEmpty) {
          await adicionarRegistros2(nome, email);
        } else {
          debugPrint("Erro: Campos não podem estar vazios");
        }
      },
    ).mostrarDialog();
  }

  Future<void> refresh() async {
    await buscarRegistros2();
  }
}
