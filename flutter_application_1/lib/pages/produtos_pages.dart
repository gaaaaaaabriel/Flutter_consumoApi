import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/produtos_controller.dart';
import 'package:flutter_application_1/models/produto.dart';
import 'package:flutter_application_1/repository/produtos_repositrys.dart';
import 'package:flutter_application_1/utils/atlualizar.dart';

class ProdutosPages extends StatefulWidget {
  const ProdutosPages({super.key});

  @override
  State<ProdutosPages> createState() => _ProdutosPagesState();
}

class _ProdutosPagesState extends State<ProdutosPages> {
  final TextEditingController _searchController = TextEditingController();
  final ProdutosController controller = ProdutosController();

  List<Produto> _produtos = [];
  List<Produto> _produtosFiltrados = [];
  

  @override
  void dispose() {
    _searchController
        .dispose(); // Limpa o controlador quando o widget for removido
    super.dispose();
  }

//----------------------------------------------------------------------\\
  Future<void> buscarRegistros2() async {
    _produtos = await crud.buscarRegistros();
    setState(() {
      _produtosFiltrados = _produtos;
    });
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
      setState(() {});
      await buscarRegistros2();
    }
  }

  Future<void> adicionarRegistros2(String nome, String email) async {
    bool sucesso = await crud.adicionarRegistro(nome, email);
    if (sucesso) {
      await buscarRegistros2();
    }
  }
//----------------------------------------------------------------------\\

  //funçaõ para filtrar os registros
  void _filtrarRegistros() {
    String pesquisa = _searchController.text.toLowerCase();
    setState(() {
      _produtosFiltrados = _produtos.where((produto) {
        return produto.nome.toLowerCase().contains(pesquisa) ||
            produto.email.toLowerCase().contains(pesquisa);
      }).toList();
    });
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
          await adicionarRegistros2(nome, email);
        } else {
          debugPrint("Erro: Campos não podem estar vazios");
        }
      },
    ).mostrarDialog();
  }

  @override
  void initState() {
    super.initState();
    controller.buscarBuilder = controller.buscarRegistros2();
    
  }

  Future<void> _refresh() async {
    await buscarRegistros2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Pesquisar',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 25, 43),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 25, 43),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 0, 25, 43),
              ),
            ),
          ),
          onChanged: (text) {
            _filtrarRegistros(); // Atualiza a lista filtrada quando o texto muda
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
          future:  controller.buscarBuilder,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasError) {
              var registros = _produtosFiltrados;

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          await atualizarRegistro2(
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
                                      await excluirRegistros2(registro.id);
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
                            backgroundColor:
                                const Color.fromARGB(255, 0, 25, 43),
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
        ),
      ),
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
