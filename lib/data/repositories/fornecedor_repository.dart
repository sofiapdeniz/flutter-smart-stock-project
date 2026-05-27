import '../database/database_helper.dart';

class FornecedorRepository {
  final _db = DatabaseHelper();

  Future<int> inserir(Map<String, dynamic> fornecedor) async {
    final db = await _db.database;
    return await db.insert('fornecedores', fornecedor);
  }

  Future<List<Map<String, dynamic>>> buscarTodos() async {
    final db = await _db.database;
    return await db.query('fornecedores', orderBy: 'nome ASC');
  }

  Future<Map<String, dynamic>?> buscarPorId(int id) async {
    final db = await _db.database;
    final result = await db.query('fornecedores', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> atualizar(int id, Map<String, dynamic> fornecedor) async {
    final db = await _db.database;
    return await db.update('fornecedores', fornecedor, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    return await db.delete('fornecedores', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> contarTotal() async {
    final db = await _db.database;
    final result = await db.rawQuery('SELECT COUNT(*) as total FROM fornecedores');
    return result.first['total'] as int;
  }
}
