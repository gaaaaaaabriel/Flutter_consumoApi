import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/produtos_controller.dart';
import 'package:flutter_application_1/utils/atlualizar.dart';
import 'package:flutter_application_1/utils/searchBar.dart';

class ProdutosPages extends StatefulWidget {
  const ProdutosPages({super.key});

  @override
  State<ProdutosPages> createState() => _ProdutosPagesState();
}

class _ProdutosPagesState extends State<ProdutosPages> {
  //instancias
  final TextEditingController _searchController = TextEditingController();
  final ProdutosController controller = ProdutosController();

  //funções
  @override
  void dispose() {
    _searchController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
    controller.context = context;
    controller.buscarRegistro = controller.buscarRegistros2();
  }

  //Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BarraDePesquisa(
          nomeBarra: 'Pesquisa',
          searchController: _searchController,
          controller: controller,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: FutureBuilder(
          future: controller.buscarRegistro,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasError) {
              var registros = controller.produtosFiltrados;

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
                                          await controller.atualizarRegistro2(
                                              registro.id, nome, email);
                                          Navigator.of(context).pop();
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
                                      await controller
                                          .excluirRegistros2(registro.id);
                                      Navigator.of(context).pop();
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
        onPressed: controller.showAddProductDialog,
        backgroundColor: const Color.fromARGB(255, 0, 25, 43),
        child: const Icon(
          Icons.add,
          color: Colors.pink,
        ),
      ),
    );
  }
}
