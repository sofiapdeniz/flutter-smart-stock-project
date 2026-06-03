import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/produto.dart';
import 'api_config.dart';

class ProdutoService {
  final http.Client _client = http.Client();
  List<Produto>? _cache;
  DateTime? _cacheTimestamp;

  bool get _cacheValido =>
      _cache != null &&
      _cacheTimestamp != null &&
      DateTime.now().difference(_cacheTimestamp!) < ApiConfig.cacheDuration;

  Future<List<Produto>> buscarTodos({bool forceRefresh = false}) async {
    if (!forceRefresh && _cacheValido) return _cache!;

    try {
      final response = await _client
          .get(Uri.parse('${ApiConfig.baseUrl}/Produto'))
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        _cache = json.map((e) => Produto.fromJson(e as Map<String, dynamic>)).toList();
        _cacheTimestamp = DateTime.now();
        return _cache!;
      }
      throw ApiException('Erro ao buscar produtos', response.statusCode);
    } catch (e) {
      if (_cache != null) return _cache!;
      rethrow;
    }
  }

  Future<Produto?> buscarPorId(int id) async {
    try {
      final response = await _client
          .get(Uri.parse('${ApiConfig.baseUrl}/Produto/$id'))
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        return Produto.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 404) return null;
      throw ApiException('Erro ao buscar produto', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<Produto> criar(Produto produto) async {
    try {
      final response = await _client
          .post(
            Uri.parse('${ApiConfig.baseUrl}/Produto'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nome': produto.nome,
              'codigo': produto.codigo,
              'descricao': produto.descricao,
              'precoUnitario': produto.precoUnitario,
              'unidadeMedida': produto.unidadeMedida,
            }),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 201) {
        _invalidarCache();
        return Produto.fromJson(jsonDecode(response.body));
      }
      throw ApiException('Erro ao criar produto', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<Produto?> atualizar(int id, Produto produto) async {
    try {
      final response = await _client
          .put(
            Uri.parse('${ApiConfig.baseUrl}/Produto/$id'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nome': produto.nome,
              'codigo': produto.codigo,
              'descricao': produto.descricao,
              'precoUnitario': produto.precoUnitario,
              'unidadeMedida': produto.unidadeMedida,
            }),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        _invalidarCache();
        return Produto.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 404) return null;
      throw ApiException('Erro ao atualizar produto', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deletar(int id) async {
    try {
      final response = await _client
          .delete(Uri.parse('${ApiConfig.baseUrl}/Produto/$id'))
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

class ApiException implements Exception {
  final String message;
  final int statusCode;
  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}
