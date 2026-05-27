import 'package:flutter/material.dart';
import '../../data/repositories/usuario_repository.dart';

class AuthProvider extends ChangeNotifier {
  final UsuarioRepository _repository = UsuarioRepository();

  bool _autenticado = false;
  int _usuarioId = 0;
  String _email = '';
  String _nome = '';
  String _tipoUsuario = '';

  bool get autenticado => _autenticado;
  int get usuarioId => _usuarioId;
  String get email => _email;
  String get nome => _nome;
  String get tipoUsuario => _tipoUsuario;

  Future<bool> login({required String email, required String senha}) async {
    try {
      final usuario = await _repository.buscarPorEmail(email);
      print('LOGIN DEBUG - email: $email, senha: $senha');
      print('LOGIN DEBUG - usuario encontrado: $usuario');

      if (usuario == null) return false;
      if (usuario['senha'] != senha) return false;

      _autenticado = true;
      _usuarioId = usuario['id'] as int;
      _email = usuario['email'] as String;
      _nome = usuario['nome'] as String;
      _tipoUsuario = usuario['tipo'] as String;
      notifyListeners();
      return true;
    } catch (e) {
      print('LOGIN DEBUG - erro: $e');
      return false;
    }
  }

  Future<bool> cadastrar({
    required String nome,
    required String email,
    required String senha,
    required String tipo,
  }) async {
    try {
      final existente = await _repository.buscarPorEmail(email);
      if (existente != null) return false;

      final id = await _repository.inserir({
        'nome': nome,
        'email': email,
        'senha': senha,
        'tipo': tipo,
        'telefone': '',
        'data_criacao': DateTime.now().toIso8601String(),
      });

      _usuarioId = id;
    } catch (_) {
      _usuarioId = DateTime.now().millisecondsSinceEpoch;
    }
    notifyListeners();
    return true;
  }

  void logout() {
    _autenticado = false;
    _usuarioId = 0;
    _email = '';
    _nome = '';
    _tipoUsuario = '';
    notifyListeners();
  }
}
