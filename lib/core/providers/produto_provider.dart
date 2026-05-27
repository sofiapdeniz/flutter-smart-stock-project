import 'package:flutter/material.dart';
import '../../models/produto.dart';
import '../../data/repositories/produto_repository.dart';

class ProdutoProvider extends ChangeNotifier {
  final ProdutoRepository _repository = ProdutoRepository();
  List<Produto> _produtos = [];
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

  Future<void> carregarProdutos() async {
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
    notifyListeners();
  }

  Future<void> adicionarProduto(Produto produto) async {
    final id = await _repository.inserir({
      'nome': produto.nome,
      'codigo': produto.codigo,
      'descricao': produto.descricao,
      'preco_unitario': produto.precoUnitario,
      'unidade_medida': produto.unidadeMedida,
      'data_criacao': produto.dataCriacao.toIso8601String(),
      'data_atualizacao': produto.dataAtualizacao.toIso8601String(),
    });
    _produtos.add(produto.copyWith(id: id));
    notifyListeners();
  }

  Future<void> atualizarProduto(int id, Produto produtoAtualizado) async {
    await _repository.atualizar(id, {
      'nome': produtoAtualizado.nome,
      'codigo': produtoAtualizado.codigo,
      'descricao': produtoAtualizado.descricao,
      'preco_unitario': produtoAtualizado.precoUnitario,
      'unidade_medida': produtoAtualizado.unidadeMedida,
      'data_atualizacao': DateTime.now().toIso8601String(),
    });
    final index = _produtos.indexWhere((p) => p.id == id);
    if (index != -1) {
      _produtos[index] = produtoAtualizado;
      notifyListeners();
    }
  }

  Future<void> removerProduto(int id) async {
    await _repository.deletar(id);
    _produtos.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
