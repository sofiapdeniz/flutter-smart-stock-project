class ItemPedido {
  final int id;
  final String unidadeMedida;
  final double precoUnitario;
  final int quantidade;
  final int pedidoId;
  final int produtoId;
  final DateTime dataCriacao;
  final DateTime dataAtualizacao;

  const ItemPedido({
    required this.id,
    required this.unidadeMedida,
    required this.precoUnitario,
    required this.quantidade,
    required this.pedidoId,
    required this.produtoId,
    required this.dataCriacao,
    required this.dataAtualizacao,
  });

  factory ItemPedido.fromJson(Map<String, dynamic> json) {
    return ItemPedido(
      id: json['id'] as int,
      unidadeMedida: json['unidadeMedida'] as String,
      precoUnitario: (json['precoUnitario'] as num).toDouble(),
      quantidade: json['quantidade'] as int,
      pedidoId: json['pedidoId'] as int,
      produtoId: json['produtoId'] as int,
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
      dataAtualizacao: DateTime.parse(json['dataAtualizacao'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unidadeMedida': unidadeMedida,
      'precoUnitario': precoUnitario,
      'quantidade': quantidade,
      'pedidoId': pedidoId,
      'produtoId': produtoId,
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataAtualizacao': dataAtualizacao.toIso8601String(),
    };
  }

  ItemPedido copyWith({
    int? id,
    String? unidadeMedida,
    double? precoUnitario,
    int? quantidade,
    int? pedidoId,
    int? produtoId,
    DateTime? dataCriacao,
    DateTime? dataAtualizacao,
  }) {
    return ItemPedido(
      id: id ?? this.id,
      unidadeMedida: unidadeMedida ?? this.unidadeMedida,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      quantidade: quantidade ?? this.quantidade,
      pedidoId: pedidoId ?? this.pedidoId,
      produtoId: produtoId ?? this.produtoId,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemPedido &&
        other.id == id &&
        other.unidadeMedida == unidadeMedida &&
        other.precoUnitario == precoUnitario &&
        other.quantidade == quantidade &&
        other.pedidoId == pedidoId &&
        other.produtoId == produtoId &&
        other.dataCriacao == dataCriacao &&
        other.dataAtualizacao == dataAtualizacao;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      unidadeMedida,
      precoUnitario,
      quantidade,
      pedidoId,
      produtoId,
      dataCriacao,
      dataAtualizacao,
    );
  }
}
