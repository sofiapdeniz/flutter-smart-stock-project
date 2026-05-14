import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _autenticado = false;
  String _email = '';
  String _nome = '';
  String _tipoUsuario = '';

  bool get autenticado => _autenticado;
  String get email => _email;
  String get nome => _nome;
  String get tipoUsuario => _tipoUsuario;

  Future<void> login({required String email, required String nome, required String tipo}) async {
    _autenticado = true;
    _email = email;
    _nome = nome;
    _tipoUsuario = tipo;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autenticado', true);
    await prefs.setString('email', email);
    await prefs.setString('nome', nome);
    await prefs.setString('tipo_usuario', tipo);

    notifyListeners();
  }

  Future<void> logout() async {
    _autenticado = false;
    _email = '';
    _nome = '';
    _tipoUsuario = '';

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  Future<void> carregarSessao() async {
    final prefs = await SharedPreferences.getInstance();
    _autenticado = prefs.getBool('autenticado') ?? false;
    _email = prefs.getString('email') ?? '';
    _nome = prefs.getString('nome') ?? '';
    _tipoUsuario = prefs.getString('tipo_usuario') ?? '';
    notifyListeners();
  }
}
