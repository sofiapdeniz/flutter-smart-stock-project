import 'package:flutter/material.dart';
import '../../models/pedido_venda.dart';
import '../../data/services/pedido_venda_service.dart';
import '../di/service_locator.dart';

class ItemCarrinho {
  final String nome;
  final double preco;
  final int quantidade;
  final int? produtoId;

  ItemCarrinho({required this.nome, required this.preco, required this.quantidade, this.produtoId});
}

class PedidoProvider extends ChangeNotifier {
  final PedidoVendaService _service = getIt<PedidoVendaService>();

  final List<ItemCarrinho> _itensCarrinho = [];
  List<PedidoVenda> _pedidosFinalizados = [];
  bool _carregando = false;
  String? _erro;

  List<ItemCarrinho> get itensCarrinho => List.unmodifiable(_itensCarrinho);
  List<PedidoVenda> get pedidosFinalizados => List.unmodifiable(_pedidosFinalizados);
  int get totalPedidos => _pedidosFinalizados.length;
  bool get carregando => _carregando;
  String? get erro => _erro;

  double get valorTotal =>
      _itensCarrinho.fold(0, (sum, item) => sum + (item.preco * item.quantidade));

  Future<void> carregarPedidos() async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _pedidosFinalizados = await _service.buscarTodos();
    } catch (_) {
      _erro = 'Sem conexão';
    }

    _carregando = false;
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

  Future<bool> finalizarPedido({
    required String clienteNome,
    required String telefone,
    required String tipoEntrega,
    String? endereco,
    String? bairro,
    String? numero,
  }) async {
    try {
      await _service.criar(
        clienteNome: clienteNome,
        tipoEntrega: tipoEntrega.toLowerCase() == 'entrega' ? 0 : 1,
        enderecoEntrega: endereco ?? '',
        bairroEntrega: bairro ?? '',
        numeroEnderecoEntrega: int.tryParse(numero ?? '0') ?? 0,
        telefoneCliente: telefone,
        itens: _itensCarrinho.map((item) => {
          'produtoId': item.produtoId ?? 0,
          'quantidade': item.quantidade,
          'precoUnitario': item.preco,
          'unidadeMedida': 'UN',
        }).toList(),
      );

      _itensCarrinho.clear();
      await carregarPedidos();
      return true;
    } catch (_) {
      _itensCarrinho.clear();
      notifyListeners();
      return false;
    }
  }
}
