import 'package:flutter_test/flutter_test.dart';
import 'package:smart_stock/models/produto.dart';

void main() {
  group('Produto', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {
        'id': 1,
        'nome': 'Produto Teste',
        'codigo': 123,
        'descricao': 'Descrição do produto',
        'precoUnitario': 50.0,
        'unidadeMedida': 'UN',
        'dataCriacao': '2024-01-01T10:00:00.000Z',
        'dataAtualizacao': '2024-01-02T10:00:00.000Z',
      };

      final produto = Produto.fromJson(json);

      expect(produto.id, 1);
      expect(produto.nome, 'Produto Teste');
      expect(produto.codigo, 123);
      expect(produto.descricao, 'Descrição do produto');
      expect(produto.precoUnitario, 50.0);
      expect(produto.unidadeMedida, 'UN');
      expect(produto.dataCriacao, DateTime.parse('2024-01-01T10:00:00.000Z'));
      expect(produto.dataAtualizacao, DateTime.parse('2024-01-02T10:00:00.000Z'));
    });

    test('toJson produz o JSON correto', () {
      final produto = Produto(
        id: 1,
        nome: 'Produto Teste',
        codigo: 123,
        descricao: 'Descrição do produto',
        precoUnitario: 50.0,
        unidadeMedida: 'UN',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final json = produto.toJson();

      expect(json['id'], 1);
      expect(json['nome'], 'Produto Teste');
      expect(json['codigo'], 123);
      expect(json['descricao'], 'Descrição do produto');
      expect(json['precoUnitario'], 50.0);
      expect(json['unidadeMedida'], 'UN');
      expect(json['dataCriacao'], '2024-01-01T10:00:00.000Z');
      expect(json['dataAtualizacao'], '2024-01-02T10:00:00.000Z');
    });

    test('copyWith modifica apenas os campos especificados', () {
      final produto = Produto(
        id: 1,
        nome: 'Produto Teste',
        codigo: 123,
        descricao: 'Descrição do produto',
        precoUnitario: 50.0,
        unidadeMedida: 'UN',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final produtoModificado = produto.copyWith(
        nome: 'Produto Modificado',
        precoUnitario: 75.0,
      );

      expect(produtoModificado.id, 1);
      expect(produtoModificado.nome, 'Produto Modificado');
      expect(produtoModificado.codigo, 123);
      expect(produtoModificado.descricao, 'Descrição do produto');
      expect(produtoModificado.precoUnitario, 75.0);
      expect(produtoModificado.unidadeMedida, 'UN');
    });

    test('== compara produtos por valor', () {
      final produto1 = Produto(
        id: 1,
        nome: 'Produto Teste',
        codigo: 123,
        descricao: 'Descrição',
        precoUnitario: 50.0,
        unidadeMedida: 'UN',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final produto2 = Produto(
        id: 1,
        nome: 'Produto Teste',
        codigo: 123,
        descricao: 'Descrição',
        precoUnitario: 50.0,
        unidadeMedida: 'UN',
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      expect(produto1, produto2);
      expect(produto1.hashCode, produto2.hashCode);
    });
  });
}
