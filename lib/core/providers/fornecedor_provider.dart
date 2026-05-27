import 'package:flutter/material.dart';
import '../../models/fornecedor.dart';
import '../../data/repositories/fornecedor_repository.dart';

class FornecedorProvider extends ChangeNotifier {
  final FornecedorRepository _repository = FornecedorRepository();
  List<Fornecedor> _fornecedores = [];

  List<Fornecedor> get fornecedores => List.unmodifiable(_fornecedores);
  int get totalFornecedores => _fornecedores.length;

  Future<void> carregarFornecedores() async {
    final dados = await _repository.buscarTodos();
    _fornecedores = dados.map((map) => Fornecedor(
      id: map['id'] as int,
      nome: map['nome'] as String,
      cnpj: map['cnpj'] as String,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
      endereco: map['endereco'] as String,
      dataCriacao: DateTime.parse(map['data_criacao'] as String),
      dataAtualizacao: DateTime.parse(map['data_atualizacao'] as String),
    )).toList();
    notifyListeners();
  }

  Future<void> adicionarFornecedor(Fornecedor fornecedor) async {
    final id = await _repository.inserir({
      'nome': fornecedor.nome,
      'cnpj': fornecedor.cnpj,
      'telefone': fornecedor.telefone,
      'email': fornecedor.email,
      'endereco': fornecedor.endereco,
      'data_criacao': fornecedor.dataCriacao.toIso8601String(),
      'data_atualizacao': fornecedor.dataAtualizacao.toIso8601String(),
    });
    _fornecedores.add(fornecedor.copyWith(id: id));
    notifyListeners();
  }

  Future<void> atualizarFornecedor(int id, Fornecedor fornecedorAtualizado) async {
    await _repository.atualizar(id, {
      'nome': fornecedorAtualizado.nome,
      'cnpj': fornecedorAtualizado.cnpj,
      'telefone': fornecedorAtualizado.telefone,
      'email': fornecedorAtualizado.email,
      'endereco': fornecedorAtualizado.endereco,
      'data_atualizacao': DateTime.now().toIso8601String(),
    });
    final index = _fornecedores.indexWhere((f) => f.id == id);
    if (index != -1) {
      _fornecedores[index] = fornecedorAtualizado;
      notifyListeners();
    }
  }

  Future<void> removerFornecedor(int id) async {
    await _repository.deletar(id);
    _fornecedores.removeWhere((f) => f.id == id);
    notifyListeners();
  }
}
