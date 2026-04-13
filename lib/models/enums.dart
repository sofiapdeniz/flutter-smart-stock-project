enum TipoEntrega {
  entrega,
  retirada;

  String toJson() => name;

  static TipoEntrega fromJson(String json) {
    return TipoEntrega.values.firstWhere(
      (e) => e.name == json.toLowerCase(),
      orElse: () => TipoEntrega.entrega,
    );
  }
}

enum CondicaoPagamento {
  aVista,
  parcelado30,
  parcelado60,
  parcelado90;

  String toJson() => name;

  static CondicaoPagamento fromJson(String json) {
    return CondicaoPagamento.values.firstWhere(
      (e) => e.name == json,
      orElse: () => CondicaoPagamento.aVista,
    );
  }
}
