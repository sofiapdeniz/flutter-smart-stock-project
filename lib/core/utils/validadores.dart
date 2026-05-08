class Validadores {
  static String? obrigatorio(String? valor, [String campo = 'campo']) {
    if (valor == null || valor.trim().isEmpty) return 'Informe o $campo';
    return null;
  }

  static String? email(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Informe o email';
    final regex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    if (!regex.hasMatch(valor)) return 'Email inválido';
    return null;
  }

  static String? senha(String? valor) {
    if (valor == null || valor.isEmpty) return 'Informe a senha';
    if (valor.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  static String? confirmarSenha(String? valor, String senha) {
    if (valor == null || valor.isEmpty) return 'Confirme a senha';
    if (valor != senha) return 'Senhas não coincidem';
    return null;
  }

  static String? telefone(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Informe o telefone';
    final apenasDigitos = valor.replaceAll(RegExp(r'[^\d]'), '');
    if (apenasDigitos.length < 10 || apenasDigitos.length > 11) {
      return 'Telefone inválido (10 ou 11 dígitos)';
    }
    return null;
  }

  static String? cnpj(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Informe o CNPJ';
    final apenasDigitos = valor.replaceAll(RegExp(r'[^\d]'), '');
    if (apenasDigitos.length != 14) return 'CNPJ deve ter 14 dígitos';
    return null;
  }

  static String? preco(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Informe o preço';
    final numero = double.tryParse(valor);
    if (numero == null || numero <= 0) return 'Preço deve ser maior que zero';
    return null;
  }

  static String? codigo(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Informe o código';
    if (int.tryParse(valor) == null) return 'Código inválido';
    return null;
  }
}
