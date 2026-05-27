import '../database/database_helper.dart';

class ProdutoRepository {
  final _db = DatabaseHelper();

  Future<int> inserir(Map<String, dynamic> produto) async {
    final db = await _db.database;
    return await db.insert('produtos', produto);
  }

  Future<List<Map<String, dynamic>>> buscarTodos() async {
    final db = await _db.database;
    return await db.query('produtos', orderBy: 'nome ASC');
  }

  Future<Map<String, dynamic>?> buscarPorId(int id) async {
    final db = await _db.database;
    final result = await db.query('produtos', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> buscarPorNome(String nome) async {
    final db = await _db.database;
    return await db.query('produtos', where: 'nome LIKE ?', whereArgs: ['%$nome%']);
  }

  Future<int> atualizar(int id, Map<String, dynamic> produto) async {
    final db = await _db.database;
    return await db.update('produtos', produto, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    return await db.delete('produtos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> contarTotal() async {
    final db = await _db.database;
    final result = await db.rawQuery('SELECT COUNT(*) as total FROM produtos');
    return result.first['total'] as int;
  }
}
