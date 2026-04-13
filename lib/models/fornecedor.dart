class Fornecedor {
  final int id;
  final String nome;
  final String cnpj;
  final String telefone;
  final String email;
  final String endereco;
  final DateTime dataCriacao;
  final DateTime dataAtualizacao;

  const Fornecedor({
    required this.id,
    required this.nome,
    required this.cnpj,
    required this.telefone,
    required this.email,
    required this.endereco,
    required this.dataCriacao,
    required this.dataAtualizacao,
  });

  factory Fornecedor.fromJson(Map<String, dynamic> json) {
    return Fornecedor(
      id: json['id'] as int,
      nome: json['nome'] as String,
      cnpj: json['cnpj'] as String,
      telefone: json['telefone'] as String,
      email: json['email'] as String,
      endereco: json['endereco'] as String,
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
      dataAtualizacao: DateTime.parse(json['dataAtualizacao'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cnpj': cnpj,
      'telefone': telefone,
      'email': email,
      'endereco': endereco,
      'dataCriacao': dataCriacao.toIso8601String(),
      'dataAtualizacao': dataAtualizacao.toIso8601String(),
    };
  }

  Fornecedor copyWith({
    int? id,
    String? nome,
    String? cnpj,
    String? telefone,
    String? email,
    String? endereco,
    DateTime? dataCriacao,
    DateTime? dataAtualizacao,
  }) {
    return Fornecedor(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cnpj: cnpj ?? this.cnpj,
      telefone: telefone ?? this.telefone,
      email: email ?? this.email,
      endereco: endereco ?? this.endereco,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      dataAtualizacao: dataAtualizacao ?? this.dataAtualizacao,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Fornecedor &&
        other.id == id &&
        other.nome == nome &&
        other.cnpj == cnpj &&
        other.telefone == telefone &&
        other.email == email &&
        other.endereco == endereco &&
        other.dataCriacao == dataCriacao &&
        other.dataAtualizacao == dataAtualizacao;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nome,
      cnpj,
      telefone,
      email,
      endereco,
      dataCriacao,
      dataAtualizacao,
    );
  }
}
