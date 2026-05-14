import 'package:flutter/material.dart';
import '../../models/fornecedor.dart';

class FornecedorProvider extends ChangeNotifier {
  final List<Fornecedor> _fornecedores = [];

  List<Fornecedor> get fornecedores => List.unmodifiable(_fornecedores);
  int get totalFornecedores => _fornecedores.length;

  void adicionarFornecedor(Fornecedor fornecedor) {
    _fornecedores.add(fornecedor);
    notifyListeners();
  }

  void atualizarFornecedor(int id, Fornecedor fornecedorAtualizado) {
    final index = _fornecedores.indexWhere((f) => f.id == id);
    if (index != -1) {
      _fornecedores[index] = fornecedorAtualizado;
      notifyListeners();
    }
  }

  void removerFornecedor(int id) {
    _fornecedores.removeWhere((f) => f.id == id);
    notifyListeners();
  }
}
