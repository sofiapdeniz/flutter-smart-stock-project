import 'package:flutter/material.dart';
import '../../models/produto.dart';

class ProdutoProvider extends ChangeNotifier {
  final List<Produto> _produtos = [];
  String _filtro = '';

  List<Produto> get produtos {
    if (_filtro.isEmpty) return List.unmodifiable(_produtos);
    return _produtos
        .where((p) => p.nome.toLowerCase().contains(_filtro.toLowerCase()))
        .toList();
  }

  int get totalProdutos => _produtos.length;
  String get filtro => _filtro;

  void setFiltro(String valor) {
    _filtro = valor;
    notifyListeners();
  }

  void adicionarProduto(Produto produto) {
    _produtos.add(produto);
    notifyListeners();
  }

  void atualizarProduto(int id, Produto produtoAtualizado) {
    final index = _produtos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _produtos[index] = produtoAtualizado;
      notifyListeners();
    }
  }

  void removerProduto(int id) {
    _produtos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
