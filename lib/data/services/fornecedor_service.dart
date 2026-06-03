import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/fornecedor.dart';
import 'api_config.dart';
import 'produto_service.dart';

class FornecedorService {
  final http.Client _client = http.Client();
  List<Fornecedor>? _cache;
  DateTime? _cacheTimestamp;

  bool get _cacheValido =>
      _cache != null &&
      _cacheTimestamp != null &&
      DateTime.now().difference(_cacheTimestamp!) < ApiConfig.cacheDuration;

  Future<List<Fornecedor>> buscarTodos({bool forceRefresh = false}) async {
    if (!forceRefresh && _cacheValido) return _cache!;

    try {
      final response = await _client
          .get(Uri.parse('${ApiConfig.baseUrl}/Fornecedor'))
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        _cache = json.map((e) => Fornecedor.fromJson(e as Map<String, dynamic>)).toList();
        _cacheTimestamp = DateTime.now();
        return _cache!;
      }
      throw ApiException('Erro ao buscar fornecedores', response.statusCode);
    } catch (e) {
      if (_cache != null) return _cache!;
      rethrow;
    }
  }

  Future<Fornecedor?> buscarPorId(int id) async {
    try {
      final response = await _client
          .get(Uri.parse('${ApiConfig.baseUrl}/Fornecedor/$id'))
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        return Fornecedor.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 404) return null;
      throw ApiException('Erro ao buscar fornecedor', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<Fornecedor> criar(Fornecedor fornecedor) async {
    try {
      final response = await _client
          .post(
            Uri.parse('${ApiConfig.baseUrl}/Fornecedor'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nome': fornecedor.nome,
              'cnpj': fornecedor.cnpj,
              'telefone': fornecedor.telefone,
              'email': fornecedor.email,
              'endereco': fornecedor.endereco,
            }),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 201) {
        _invalidarCache();
        return Fornecedor.fromJson(jsonDecode(response.body));
      }
      throw ApiException('Erro ao criar fornecedor', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<Fornecedor?> atualizar(int id, Fornecedor fornecedor) async {
    try {
      final response = await _client
          .put(
            Uri.parse('${ApiConfig.baseUrl}/Fornecedor/$id'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nome': fornecedor.nome,
              'cnpj': fornecedor.cnpj,
              'telefone': fornecedor.telefone,
              'email': fornecedor.email,
              'endereco': fornecedor.endereco,
            }),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        _invalidarCache();
        return Fornecedor.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 404) return null;
      throw ApiException('Erro ao atualizar fornecedor', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deletar(int id) async {
    try {
      final response = await _client
          .delete(Uri.parse('${ApiConfig.baseUrl}/Fornecedor/$id'))
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        _invalidarCache();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  void _invalidarCache() {
    _cache = null;
    _cacheTimestamp = null;
  }
}
