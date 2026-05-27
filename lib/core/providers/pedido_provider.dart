import 'package:flutter/material.dart';
import '../../data/repositories/pedido_repository.dart';
import '../../data/repositories/item_pedido_repository.dart';

class ItemCarrinho {
  final String nome;
  final double preco;
  final int quantidade;
  final int? produtoId;

  ItemCarrinho({required this.nome, required this.preco, required this.quantidade, this.produtoId});
}

class PedidoProvider extends ChangeNotifier {
  final PedidoRepository _pedidoRepository = PedidoRepository();
  final ItemPedidoRepository _itemRepository = ItemPedidoRepository();

  final List<ItemCarrinho> _itensCarrinho = [];
  List<Map<String, dynamic>> _pedidosFinalizados = [];

  List<ItemCarrinho> get itensCarrinho => List.unmodifiable(_itensCarrinho);
  List<Map<String, dynamic>> get pedidosFinalizados => List.unmodifiable(_pedidosFinalizados);
  int get totalPedidos => _pedidosFinalizados.length;

  double get valorTotal =>
      _itensCarrinho.fold(0, (sum, item) => sum + (item.preco * item.quantidade));

  Future<void> carregarPedidos() async {
    _pedidosFinalizados = await _pedidoRepository.buscarTodos();
    notifyListeners();
  }

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

  Future<void> finalizarPedido({
    required int usuarioId,
    required String tipoEntrega,
    int? enderecoId,
  }) async {
    final pedidoId = await _pedidoRepository.inserir({
      'usuario_id': usuarioId,
      'endereco_id': enderecoId,
      'tipo_entrega': tipoEntrega,
      'valor_total': valorTotal,
      'data_criacao': DateTime.now().toIso8601String(),
    });

    for (final item in _itensCarrinho) {
      await _itemRepository.inserir({
        'pedido_id': pedidoId,
        'produto_id': item.produtoId ?? 0,
        'quantidade': item.quantidade,
        'preco_unitario': item.preco,
      });
    }

    _itensCarrinho.clear();
    await carregarPedidos();
  }
}
