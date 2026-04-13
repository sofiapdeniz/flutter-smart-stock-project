import 'enums.dart';
import 'item_pedido.dart';

class PedidoVenda {
  final int id;
  final String clienteNome;
  final double valorTotal;
  final TipoEntrega tipoEntrega;
  final String enderecoEntrega;
  final String bairroEntrega;
  final int numeroEnderecoEntrega;
  final String telefoneCliente;
  final String? lojaRetirada;
  final List<ItemPedido> itensPedido;
  final DateTime dataCriacao;
  final DateTime dataAtualizacao;

  const PedidoVenda({
    required this.id,
    required this.clienteNome,
    required this.valorTotal,
    required this.tipoEntrega,
    required this.enderecoEntrega,
    required this.bairroEntrega,
    required this.numeroEnderecoEntrega,
    required this.telefoneCliente,
    this.lojaRetirada,
    required this.itensPedido,
    required this.dataCriacao,
    required this.dataAtualizacao,
  });

  factory PedidoVenda.fromJson(Map<String, dynamic> json) {
    return PedidoVenda(
      id: json['id'] as int,
      clienteNome: json['clienteNome'] as String,
      valorTotal: (json['valorTotal'] as num).toDouble(),
      tipoEntrega: TipoEntrega.fromJson(json['tipoEntrega'] as String),
      enderecoEntrega: json['enderecoEntrega'] as String,
      bairroEntrega: json['bairroEntrega'] as String,
      numeroEnderecoEntrega: json['numeroEnderecoEntrega'] as int,
      telefoneCliente: json['telefoneCliente'] as String,
      lojaRetirada: json['lojaRetirada'] as String?,
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
      'clienteNome': clienteNome,
      'valorTotal': valorTotal,
      'tipoEntrega': tipoEntrega.toJson(),
      'enderecoEntrega': enderecoEntrega,
      'bairroEntrega': bairroEntrega,
      'numeroEnderecoEntrega': numeroEnderecoEntrega,
      'telefoneCliente': telefoneCliente,
      'lojaRetirada': lojaRetirada,
      'itensPedido': itensPedido.map((item) => item.toJson()).toList(),
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataAtualizacao': dataAtualizacao.toIso8601String(),
    };
  }

  PedidoVenda copyWith({
    int? id,
    String? clienteNome,
    double? valorTotal,
    TipoEntrega? tipoEntrega,
    String? enderecoEntrega,
    String? bairroEntrega,
    int? numeroEnderecoEntrega,
    String? telefoneCliente,
    String? lojaRetirada,
    List<ItemPedido>? itensPedido,
    DateTime? dataCriacao,
    DateTime? dataAtualizacao,
  }) {
    return PedidoVenda(
      id: id ?? this.id,
      clienteNome: clienteNome ?? this.clienteNome,
      valorTotal: valorTotal ?? this.valorTotal,
      tipoEntrega: tipoEntrega ?? this.tipoEntrega,
      enderecoEntrega: enderecoEntrega ?? this.enderecoEntrega,
      bairroEntrega: bairroEntrega ?? this.bairroEntrega,
      numeroEnderecoEntrega: numeroEnderecoEntrega ?? this.numeroEnderecoEntrega,
      telefoneCliente: telefoneCliente ?? this.telefoneCliente,
      lojaRetirada: lojaRetirada ?? this.lojaRetirada,
      itensPedido: itensPedido ?? this.itensPedido,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PedidoVenda &&
        other.id == id &&
        other.clienteNome == clienteNome &&
        other.valorTotal == valorTotal &&
        other.tipoEntrega == tipoEntrega &&
        other.enderecoEntrega == enderecoEntrega &&
        other.bairroEntrega == bairroEntrega &&
        other.numeroEnderecoEntrega == numeroEnderecoEntrega &&
        other.telefoneCliente == telefoneCliente &&
        other.lojaRetirada == lojaRetirada &&
        _listEquals(other.itensPedido, itensPedido) &&
        other.dataCriacao == dataCriacao &&
        other.dataAtualizacao == dataAtualizacao;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      clienteNome,
      valorTotal,
      tipoEntrega,
      enderecoEntrega,
      bairroEntrega,
      numeroEnderecoEntrega,
      telefoneCliente,
      lojaRetirada,
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
