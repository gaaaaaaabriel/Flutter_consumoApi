class ProdutoModel {
  final int id;
  final String nome;
  final String email;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.email,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'], 
      nome: json['nome'], 
      email: json['email']
      );
  }
}
