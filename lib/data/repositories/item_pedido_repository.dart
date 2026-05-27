import '../database/database_helper.dart';

class ItemPedidoRepository {
  final _db = DatabaseHelper();

  Future<int> inserir(Map<String, dynamic> item) async {
    final db = await _db.database;
    return await db.insert('itens_pedido', item);
  }

  Future<List<Map<String, dynamic>>> buscarPorPedido(int pedidoId) async {
    final db = await _db.database;
    return await db.query('itens_pedido', where: 'pedido_id = ?', whereArgs: [pedidoId]);
  }

  Future<int> deletarPorPedido(int pedidoId) async {
    final db = await _db.database;
    return await db.delete('itens_pedido', where: 'pedido_id = ?', whereArgs: [pedidoId]);
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    return await db.delete('itens_pedido', where: 'id = ?', whereArgs: [id]);
  }
}
