import 'package:flutter/material.dart';
import '../../models/fornecedor.dart';
import '../../data/services/fornecedor_service.dart';
import '../../data/repositories/fornecedor_repository.dart';
import '../di/service_locator.dart';

class FornecedorProvider extends ChangeNotifier {
  final FornecedorService _service = getIt<FornecedorService>();
  final FornecedorRepository _repository = getIt<FornecedorRepository>();
  List<Fornecedor> _fornecedores = [];
  bool _carregando = false;
  String? _erro;

  List<Fornecedor> get fornecedores => List.unmodifiable(_fornecedores);
  int get totalFornecedores => _fornecedores.length;
  bool get carregando => _carregando;
  String? get erro => _erro;

  Future<void> carregarFornecedores() async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _fornecedores = await _service.buscarTodos();
    } catch (_) {
      try {
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
      } catch (_) {
        _erro = 'Sem conexão e sem dados locais';
      }
    }

    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarFornecedor(Fornecedor fornecedor) async {
    try {
      final criado = await _service.criar(fornecedor);
      _fornecedores.add(criado);
    } catch (_) {
      _fornecedores.add(fornecedor.copyWith(id: DateTime.now().millisecondsSinceEpoch));
    }

    try {
      await _repository.inserir({
        'nome': fornecedor.nome,
        'cnpj': fornecedor.cnpj,
        'telefone': fornecedor.telefone,
        'email': fornecedor.email,
        'endereco': fornecedor.endereco,
        'data_criacao': fornecedor.dataCriacao.toIso8601String(),
        'data_atualizacao': fornecedor.dataAtualizacao.toIso8601String(),
      });
    } catch (_) {}

    notifyListeners();
  }

  Future<void> atualizarFornecedor(int id, Fornecedor fornecedorAtualizado) async {
    try {
      await _service.atualizar(id, fornecedorAtualizado);
    } catch (_) {}

    final index = _fornecedores.indexWhere((f) => f.id == id);
    if (index != -1) {
      _fornecedores[index] = fornecedorAtualizado;
      notifyListeners();
    }
  }

  Future<void> removerFornecedor(int id) async {
    try {
      await _service.deletar(id);
    } catch (_) {}

    try {
      await _repository.deletar(id);
    } catch (_) {}

    _fornecedores.removeWhere((f) => f.id == id);
    notifyListeners();
  }
}
