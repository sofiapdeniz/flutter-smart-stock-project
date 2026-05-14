import 'package:flutter/material.dart';

class ItemCarrinho {
  final String nome;
  final double preco;
  final int quantidade;

  ItemCarrinho({required this.nome, required this.preco, required this.quantidade});
}

class PedidoProvider extends ChangeNotifier {
  final List<ItemCarrinho> _itensCarrinho = [];
  final List<Map<String, dynamic>> _pedidosFinalizados = [];

  List<ItemCarrinho> get itensCarrinho => List.unmodifiable(_itensCarrinho);
  List<Map<String, dynamic>> get pedidosFinalizados => List.unmodifiable(_pedidosFinalizados);
  int get totalPedidos => _pedidosFinalizados.length;

  double get valorTotal =>
      _itensCarrinho.fold(0, (sum, item) => sum + (item.preco * item.quantidade));

  void adicionarItem(String nome, double preco, int quantidade) {
    _itensCarrinho.add(ItemCarrinho(nome: nome, preco: preco, quantidade: quantidade));
    notifyListeners();
  }

  void removerItem(int index) {
    _itensCarrinho.removeAt(index);
    notifyListeners();
  }

  void limparCarrinho() {
    _itensCarrinho.clear();
    notifyListeners();
  }

  void finalizarPedido({
    required String clienteNome,
    required String telefone,
    required String tipoEntrega,
    String? endereco,
    String? bairro,
    String? numero,
  }) {
    _pedidosFinalizados.add({
      'cliente': clienteNome,
      'telefone': telefone,
      'tipoEntrega': tipoEntrega,
      'endereco': endereco,
      'bairro': bairro,
      'numero': numero,
      'itens': List<ItemCarrinho>.from(_itensCarrinho),
      'valorTotal': valorTotal,
      'data': DateTime.now().toIso8601String(),
    });
    _itensCarrinho.clear();
    notifyListeners();
  }
}
