import 'package:flutter_test/flutter_test.dart';
import 'package:smart_stock/models/fornecedor.dart';

void main() {
  group('Fornecedor', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {
        'id': 1,
        'nome': 'Fornecedor Teste',
        'cnpj': '12.345.678/0001-90',
        'telefone': '(14) 99999-9999',
        'email': 'contato@fornecedor.com',
        'endereco': 'Rua Teste, 123',
        'dataCriacao': '2024-01-01T10:00:00.000Z',
        'dataAtualizacao': '2024-01-02T10:00:00.000Z',
      };

      final fornecedor = Fornecedor.fromJson(json);

      expect(fornecedor.id, 1);
      expect(fornecedor.nome, 'Fornecedor Teste');
      expect(fornecedor.cnpj, '12.345.678/0001-90');
      expect(fornecedor.telefone, '(14) 99999-9999');
      expect(fornecedor.email, 'contato@fornecedor.com');
      expect(fornecedor.endereco, 'Rua Teste, 123');
    });

    test('toJson produz o JSON correto', () {
      final fornecedor = Fornecedor(
        id: 1,
        nome: 'Fornecedor Teste',
        cnpj: '12.345.678/0001-90',
        telefone: '(14) 99999-9999',
        email: 'contato@fornecedor.com',
        endereco: 'Rua Teste, 123',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final json = fornecedor.toJson();

      expect(json['id'], 1);
      expect(json['nome'], 'Fornecedor Teste');
      expect(json['cnpj'], '12.345.678/0001-90');
      expect(json['telefone'], '(14) 99999-9999');
      expect(json['email'], 'contato@fornecedor.com');
      expect(json['endereco'], 'Rua Teste, 123');
    });

    test('copyWith modifica apenas os campos especificados', () {
      final fornecedor = Fornecedor(
        id: 1,
        nome: 'Fornecedor Teste',
        cnpj: '12.345.678/0001-90',
        telefone: '(14) 99999-9999',
        email: 'contato@fornecedor.com',
        endereco: 'Rua Teste, 123',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final fornecedorModificado = fornecedor.copyWith(
        telefone: '(14) 88888-8888',
        email: 'novo@fornecedor.com',
      );

      expect(fornecedorModificado.id, 1);
      expect(fornecedorModificado.nome, 'Fornecedor Teste');
      expect(fornecedorModificado.telefone, '(14) 88888-8888');
      expect(fornecedorModificado.email, 'novo@fornecedor.com');
      expect(fornecedorModificado.cnpj, '12.345.678/0001-90');
    });

    test('== compara fornecedores por valor', () {
      final fornecedor1 = Fornecedor(
        id: 1,
        nome: 'Fornecedor Teste',
        cnpj: '12.345.678/0001-90',
        telefone: '(14) 99999-9999',
        email: 'contato@fornecedor.com',
        endereco: 'Rua Teste, 123',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final fornecedor2 = Fornecedor(
        id: 1,
        nome: 'Fornecedor Teste',
        cnpj: '12.345.678/0001-90',
        telefone: '(14) 99999-9999',
        email: 'contato@fornecedor.com',
        endereco: 'Rua Teste, 123',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      expect(fornecedor1, fornecedor2);
      expect(fornecedor1.hashCode, fornecedor2.hashCode);
    });
  });
}
