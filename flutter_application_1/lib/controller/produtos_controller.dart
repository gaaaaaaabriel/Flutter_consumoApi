import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/produto.dart';
import 'package:flutter_application_1/repository/produtos_repositrys.dart';
import 'package:flutter_application_1/utils/atlualizar.dart';

class ProdutosController{
  final ProdutosRepositrys crud = ProdutosRepositrys();
  List<Produto> _produtos = [];
  List<Produto> _produtosFiltrados = [];
  late Future<void> buscarBuilder;
  late BuildContext context;

  Future<void> buscarRegistros2() async {
    _produtos = await crud.buscarRegistros();
    
      _produtosFiltrados = _produtos;
    
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

  //funçaõ para filtrar os registros
  void filtrarRegistros(TextEditingController searchController) {
    String pesquisa = searchController.text.toLowerCase();
    
      _produtosFiltrados = _produtos.where((produto) {
        return produto.nome.toLowerCase().contains(pesquisa) ||
            produto.email.toLowerCase().contains(pesquisa);
      }).toList();
  
  }

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

}