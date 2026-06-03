import 'package:flutter/material.dart';
import '../../models/produto.dart';
import '../../data/services/produto_service.dart';
import '../../data/repositories/produto_repository.dart';
import '../di/service_locator.dart';

class ProdutoProvider extends ChangeNotifier {
  final ProdutoService _service = getIt<ProdutoService>();
  final ProdutoRepository _repository = getIt<ProdutoRepository>();
  List<Produto> _produtos = [];
  String _filtro = '';
  bool _carregando = false;
  String? _erro;

  List<Produto> get produtos {
    if (_filtro.isEmpty) return List.unmodifiable(_produtos);
    return _produtos
        .where((p) => p.nome.toLowerCase().contains(_filtro.toLowerCase()))
        .toList();
  }

  int get totalProdutos => _produtos.length;
  String get filtro => _filtro;
  bool get carregando => _carregando;
  String? get erro => _erro;

  void setFiltro(String valor) {
    _filtro = valor;
    notifyListeners();
  }

  Future<void> carregarProdutos() async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _produtos = await _service.buscarTodos();
    } catch (_) {
      try {
        final dados = await _repository.buscarTodos();
        _produtos = dados.map((map) => Produto(
          id: map['id'] as int,
          nome: map['nome'] as String,
          codigo: map['codigo'] as int,
          descricao: map['descricao'] as String,
          precoUnitario: map['preco_unitario'] as double,
          unidadeMedida: map['unidade_medida'] as String,
          dataCriacao: DateTime.parse(map['data_criacao'] as String),
          dataAtualizacao: DateTime.parse(map['data_atualizacao'] as String),
        )).toList();
      } catch (_) {
        _erro = 'Sem conexão e sem dados locais';
      }
    }

    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarProduto(Produto produto) async {
    try {
      final criado = await _service.criar(produto);
      _produtos.add(criado);
    } catch (_) {
      _produtos.add(produto.copyWith(id: DateTime.now().millisecondsSinceEpoch));
    }

    try {
      await _repository.inserir({
        'nome': produto.nome,
        'codigo': produto.codigo,
        'descricao': produto.descricao,
        'preco_unitario': produto.precoUnitario,
        'unidade_medida': produto.unidadeMedida,
        'data_criacao': produto.dataCriacao.toIso8601String(),
        'data_atualizacao': produto.dataAtualizacao.toIso8601String(),
      });
    } catch (_) {}

    notifyListeners();
  }

  Future<void> atualizarProduto(int id, Produto produtoAtualizado) async {
    try {
      await _service.atualizar(id, produtoAtualizado);
    } catch (_) {}

    final index = _produtos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _produtos[index] = produtoAtualizado;
      notifyListeners();
    }
  }

  Future<void> removerProduto(int id) async {
    try {
      await _service.deletar(id);
    } catch (_) {}

    try {
      await _repository.deletar(id);
    } catch (_) {}

    _produtos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
