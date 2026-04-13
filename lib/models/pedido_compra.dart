import 'item_pedido.dart';

class PedidoCompra {
  final int id;
  final String nomeFornecedor;
  final int condicaoPagamento;
  final String contato;
  final int fornecedorId;
  final List<ItemPedido> itensPedido;
  final DateTime dataCriacao;
  final DateTime dataAtualizacao;

  const PedidoCompra({
    required this.id,
    required this.nomeFornecedor,
    required this.condicaoPagamento,
    required this.contato,
    required this.fornecedorId,
    required this.itensPedido,
    required this.dataCriacao,
    required this.dataAtualizacao,
  });

  factory PedidoCompra.fromJson(Map<String, dynamic> json) {
    return PedidoCompra(
      id: json['id'] as int,
      nomeFornecedor: json['nomeFornecedor'] as String,
      condicaoPagamento: json['condicaoPagamento'] as int,
      contato: json['contato'] as String,
      fornecedorId: json['fornecedorId'] as int,
      itensPedido: (json['itensPedido'] as List<dynamic>?)
              ?.map((item) => ItemPedido.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
      dataAtualizacao: DateTime.parse(json['dataAtualizacao'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomeFornecedor': nomeFornecedor,
      'condicaoPagamento': condicaoPagamento,
      'contato': contato,
      'fornecedorId': fornecedorId,
      'itensPedido': itensPedido.map((item) => item.toJson()).toList(),
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataAtualizacao': dataAtualizacao.toIso8601String(),
    };
  }

  PedidoCompra copyWith({
    int? id,
    String? nomeFornecedor,
    int? condicaoPagamento,
    String? contato,
    int? fornecedorId,
    List<ItemPedido>? itensPedido,
    DateTime? dataCriacao,
    DateTime? dataAtualizacao,
  }) {
    return PedidoCompra(
      id: id ?? this.id,
      nomeFornecedor: nomeFornecedor ?? this.nomeFornecedor,
      condicaoPagamento: condicaoPagamento ?? this.condicaoPagamento,
      contato: contato ?? this.contato,
      fornecedorId: fornecedorId ?? this.fornecedorId,
      itensPedido: itensPedido ?? this.itensPedido,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PedidoCompra &&
        other.id == id &&
        other.nomeFornecedor == nomeFornecedor &&
        other.condicaoPagamento == condicaoPagamento &&
        other.contato == contato &&
        other.fornecedorId == fornecedorId &&
        _listEquals(other.itensPedido, itensPedido) &&
        other.dataCriacao == dataCriacao &&
        other.dataAtualizacao == dataAtualizacao;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nomeFornecedor,
      condicaoPagamento,
      contato,
      fornecedorId,
      Object.hashAll(itensPedido),
      dataCriacao,
      dataAtualizacao,
    );
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
