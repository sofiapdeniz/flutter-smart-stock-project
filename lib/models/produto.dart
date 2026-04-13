class Produto {
  final int id;
  final String nome;
  final int codigo;
  final String descricao;
  final double precoUnitario;
  final String unidadeMedida;
  final DateTime dataCriacao;
  final DateTime dataAtualizacao;

  const Produto({
    required this.id,
    required this.nome,
    required this.codigo,
    required this.descricao,
    required this.precoUnitario,
    required this.unidadeMedida,
    required this.dataCriacao,
    required this.dataAtualizacao,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] as int,
      nome: json['nome'] as String,
      codigo: json['codigo'] as int,
      descricao: json['descricao'] as String,
      precoUnitario: (json['precoUnitario'] as num).toDouble(),
      unidadeMedida: json['unidadeMedida'] as String,
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
      dataAtualizacao: DateTime.parse(json['dataAtualizacao'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'codigo': codigo,
      'descricao': descricao,
      'precoUnitario': precoUnitario,
      'unidadeMedida': unidadeMedida,
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataAtualizacao': dataAtualizacao.toIso8601String(),
    };
  }

  Produto copyWith({
    int? id,
    String? nome,
    int? codigo,
    String? descricao,
    double? precoUnitario,
    String? unidadeMedida,
    DateTime? dataCriacao,
    DateTime? dataAtualizacao,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      unidadeMedida: unidadeMedida ?? this.unidadeMedida,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Produto &&
        other.id == id &&
        other.nome == nome &&
        other.codigo == codigo &&
        other.descricao == descricao &&
        other.precoUnitario == precoUnitario &&
        other.unidadeMedida == unidadeMedida &&
        other.dataCriacao == dataCriacao &&
        other.dataAtualizacao == dataAtualizacao;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nome,
      codigo,
      descricao,
      precoUnitario,
      unidadeMedida,
      dataCriacao,
      dataAtualizacao,
    );
  }
}
