import 'package:flutter/material.dart';
import '../../../app/data/models/produto_model.dart';

class ProdutoStory{
  final  ValueNotifier<bool> isLoading =  ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state =  ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>("");

  getProdutos()async{
    isLoading.value = true;

    try {
      
    } catch (e) {
      
    }
  }
}