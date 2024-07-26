import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/produtos_pages.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

TextEditingController pesquisaController =
        TextEditingController();

bool digitar = false;

  void _buscarProdutosPorNome() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  TextField(
          autofocus: digitar,
          controller: pesquisaController,
          decoration: const InputDecoration(
            label:  Text(
              "Pesquisar Rgeistros",
              style: TextStyle(color: Colors.white),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 25, 43),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.pink,
                ),
                onPressed: (){
                  setState(() {
                    digitar = true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: ProdutosPages(),
      ),
    );
  }
}
