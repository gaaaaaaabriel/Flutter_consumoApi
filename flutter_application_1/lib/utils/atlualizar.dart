import 'package:flutter/material.dart';

class EditarRegistroDialog {
  final BuildContext context;
  final String nomeAtual;
  final String emailAtual;
  final String nomePri;
  final String buttonFunc;
  final Function(String nome, String email) onSalvar;

  EditarRegistroDialog({
    required this.buttonFunc,
    required this.nomePri,
    required this.context,
    required this.nomeAtual,
    required this.emailAtual,
    required this.onSalvar,
  });

  void mostrarDialog() {
    TextEditingController nomeController =
        TextEditingController(text: nomeAtual);
    TextEditingController emailController =
        TextEditingController(text: emailAtual);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            nomePri,
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    label: const Text(
                      "Nome",
                      style: TextStyle(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: const Text(
                      "Email",
                      style: TextStyle(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 17, 0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onSalvar(
                      nomeController.text,
                      emailController.text,
                    );
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 255, 8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    buttonFunc,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ],
            )
          ],
          backgroundColor: const Color.fromARGB(255, 0, 25, 43),
        );
      },
    );
  }
}
