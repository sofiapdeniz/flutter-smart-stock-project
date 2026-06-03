import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/pedido_venda.dart';
import '../../models/item_pedido.dart';
import 'api_config.dart';
import 'produto_service.dart';

class PedidoVendaService {
  final http.Client _client = http.Client();
  List<PedidoVenda>? _cache;
  DateTime? _cacheTimestamp;

  bool get _cacheValido =>
      _cache != null &&
      _cacheTimestamp != null &&
      DateTime.now().difference(_cacheTimestamp!) < ApiConfig.cacheDuration;

  Future<List<PedidoVenda>> buscarTodos({bool forceRefresh = false}) async {
    if (!forceRefresh && _cacheValido) return _cache!;

    try {
      final response = await _client
          .get(Uri.parse('${ApiConfig.baseUrl}/PedidoVenda'))
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        _cache = json.map((e) => PedidoVenda.fromJson(e as Map<String, dynamic>)).toList();
        _cacheTimestamp = DateTime.now();
        return _cache!;
      }
      throw ApiException('Erro ao buscar pedidos', response.statusCode);
    } catch (e) {
      if (_cache != null) return _cache!;
      rethrow;
    }
  }

  Future<PedidoVenda?> buscarPorId(int id) async {
    try {
      final response = await _client
          .get(Uri.parse('${ApiConfig.baseUrl}/PedidoVenda/$id'))
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 200) {
        return PedidoVenda.fromJson(jsonDecode(response.body));
      }
      if (response.statusCode == 404) return null;
      throw ApiException('Erro ao buscar pedido', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<PedidoVenda> criar({
    required String clienteNome,
    required int tipoEntrega,
    required String enderecoEntrega,
    required String bairroEntrega,
    required int numeroEnderecoEntrega,
    required String telefoneCliente,
    String? lojaRetirada,
    required List<Map<String, dynamic>> itens,
  }) async {
    try {
      final response = await _client
          .post(
            Uri.parse('${ApiConfig.baseUrl}/PedidoVenda'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'clienteNome': clienteNome,
              'tipoEntrega': tipoEntrega,
              'enderecoEntrega': enderecoEntrega,
              'bairroEntrega': bairroEntrega,
              'numeroEnderecoEntrega': numeroEnderecoEntrega,
              'telefoneCliente': telefoneCliente,
              'lojaRetirada': lojaRetirada ?? '',
              'itensPedido': itens,
            }),
          )
          .timeout(ApiConfig.timeout);

      if (response.statusCode == 201) {
        _invalidarCache();
        return PedidoVenda.fromJson(jsonDecode(response.body));
      }
      throw ApiException('Erro ao criar pedido', response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deletar(int id) async {
    try {
      final response = await _client
          .delete(Uri.parse('${ApiConfig.baseUrl}/PedidoVenda/$id'))
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
