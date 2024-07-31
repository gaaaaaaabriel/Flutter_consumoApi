import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/produtos_controller.dart';

class BarraDePesquisa extends StatelessWidget {
  final String nomeBarra;
  final TextEditingController searchController;
  final ProdutosController controller;

  const BarraDePesquisa({
    super.key,
    required this.nomeBarra,
    required this.searchController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: nomeBarra,
        suffixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 25, 43),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 25, 43),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 0, 25, 43),
          ),
        ),
      ),
      onChanged: (text) {
        controller.filtrarRegistros(text);
      },
    );
  }
}
