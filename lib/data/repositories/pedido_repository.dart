import '../database/database_helper.dart';

class PedidoRepository {
  final _db = DatabaseHelper();

  Future<int> inserir(Map<String, dynamic> pedido) async {
    final db = await _db.database;
    return await db.insert('pedidos', pedido);
  }

  Future<List<Map<String, dynamic>>> buscarTodos() async {
    final db = await _db.database;
    return await db.query('pedidos', orderBy: 'data_criacao DESC');
  }

  Future<List<Map<String, dynamic>>> buscarPorUsuario(int usuarioId) async {
    final db = await _db.database;
    return await db.query('pedidos', where: 'usuario_id = ?', whereArgs: [usuarioId], orderBy: 'data_criacao DESC');
  }

  Future<Map<String, dynamic>?> buscarPorId(int id) async {
    final db = await _db.database;
    final result = await db.query('pedidos', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> atualizar(int id, Map<String, dynamic> pedido) async {
    final db = await _db.database;
    return await db.update('pedidos', pedido, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    return await db.delete('pedidos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> contarTotal() async {
    final db = await _db.database;
    final result = await db.rawQuery('SELECT COUNT(*) as total FROM pedidos');
    return result.first['total'] as int;
  }
}
