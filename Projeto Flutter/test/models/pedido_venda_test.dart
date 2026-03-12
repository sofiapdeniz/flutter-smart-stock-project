import 'package:flutter_test/flutter_test.dart';
import 'package:smart_stock/models/pedido_venda.dart';
import 'package:smart_stock/models/enums.dart';

void main() {
  group('PedidoVenda', () {
    test('fromJson cria o objeto corretamente', () {
      final json = {
        'id': 1,
        'clienteNome': 'Cliente Teste',
        'valorTotal': 150.0,
        'tipoEntrega': 'entrega',
        'enderecoEntrega': 'Rua Teste, 123',
        'bairroEntrega': 'Centro',
        'numeroEnderecoEntrega': 123,
        'telefoneCliente': '(14) 99999-9999',
        'lojaRetirada': null,
        'itensPedido': [],
        'dataCriacao': '2024-01-01T10:00:00.000Z',
        'dataAtualizacao': '2024-01-02T10:00:00.000Z',
      };

      final pedido = PedidoVenda.fromJson(json);

      expect(pedido.id, 1);
      expect(pedido.clienteNome, 'Cliente Teste');
      expect(pedido.valorTotal, 150.0);
      expect(pedido.tipoEntrega, TipoEntrega.entrega);
      expect(pedido.enderecoEntrega, 'Rua Teste, 123');
      expect(pedido.bairroEntrega, 'Centro');
      expect(pedido.numeroEnderecoEntrega, 123);
      expect(pedido.telefoneCliente, '(14) 99999-9999');
      expect(pedido.lojaRetirada, null);
    });

    test('toJson produz o JSON correto', () {
      final pedido = PedidoVenda(
        id: 1,
        clienteNome: 'Cliente Teste',
        valorTotal: 150.0,
        tipoEntrega: TipoEntrega.retirada,
        enderecoEntrega: '',
        bairroEntrega: '',
        numeroEnderecoEntrega: 0,
        telefoneCliente: '(14) 99999-9999',
        lojaRetirada: 'Loja Centro',
        itensPedido: [],
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final json = pedido.toJson();

      expect(json['id'], 1);
      expect(json['clienteNome'], 'Cliente Teste');
      expect(json['valorTotal'], 150.0);
      expect(json['tipoEntrega'], 'retirada');
      expect(json['lojaRetirada'], 'Loja Centro');
    });

    test('copyWith modifica apenas os campos especificados', () {
      final pedido = PedidoVenda(
        id: 1,
        clienteNome: 'Cliente Teste',
        valorTotal: 150.0,
        tipoEntrega: TipoEntrega.entrega,
        enderecoEntrega: 'Rua Teste, 123',
        bairroEntrega: 'Centro',
        numeroEnderecoEntrega: 123,
        telefoneCliente: '(14) 99999-9999',
        itensPedido: [],
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final pedidoModificado = pedido.copyWith(
        valorTotal: 200.0,
        tipoEntrega: TipoEntrega.retirada,
        lojaRetirada: 'Loja Sul',
      );

      expect(pedidoModificado.id, 1);
      expect(pedidoModificado.clienteNome, 'Cliente Teste');
      expect(pedidoModificado.valorTotal, 200.0);
      expect(pedidoModificado.tipoEntrega, TipoEntrega.retirada);
      expect(pedidoModificado.lojaRetirada, 'Loja Sul');
      expect(pedidoModificado.enderecoEntrega, 'Rua Teste, 123');
    });

    test('== compara pedidos por valor', () {
      final pedido1 = PedidoVenda(
        id: 1,
        clienteNome: 'Cliente Teste',
        valorTotal: 150.0,
        tipoEntrega: TipoEntrega.entrega,
        enderecoEntrega: 'Rua Teste, 123',
        bairroEntrega: 'Centro',
        numeroEnderecoEntrega: 123,
        telefoneCliente: '(14) 99999-9999',
        itensPedido: [],
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      final pedido2 = PedidoVenda(
        id: 1,
        clienteNome: 'Cliente Teste',
        valorTotal: 150.0,
        tipoEntrega: TipoEntrega.entrega,
        enderecoEntrega: 'Rua Teste, 123',
        bairroEntrega: 'Centro',
        numeroEnderecoEntrega: 123,
        telefoneCliente: '(14) 99999-9999',
        itensPedido: [],
        dataCriacao: DateTime.parse('2024-01-01T10:00:00.000Z'),
        dataAtualizacao: DateTime.parse('2024-01-02T10:00:00.000Z'),
      );

      expect(pedido1, pedido2);
      expect(pedido1.hashCode, pedido2.hashCode);
    });
  });
}
