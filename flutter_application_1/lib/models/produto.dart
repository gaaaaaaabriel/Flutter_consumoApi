class Produto{

  late int id;
  late String nome;
  late String email;

  Produto(this.id, this.nome, this.email);

  Produto.fromNuvem(Map<String, dynamic>json){
    id = int.parse(json["id"]);
    nome= json["cliente_nome"];
    email = json["cliente_email"];
  }
}