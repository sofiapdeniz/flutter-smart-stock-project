import '../database/database_helper.dart';

class UsuarioRepository {
  final _db = DatabaseHelper();

  Future<int> inserir(Map<String, dynamic> usuario) async {
    final db = await _db.database;
    return await db.insert('usuarios', usuario);
  }

  Future<List<Map<String, dynamic>>> buscarTodos() async {
    final db = await _db.database;
    return await db.query('usuarios');
  }

  Future<Map<String, dynamic>?> buscarPorEmail(String email) async {
    final db = await _db.database;
    final result = await db.query('usuarios', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> buscarPorId(int id) async {
    final db = await _db.database;
    final result = await db.query('usuarios', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> atualizar(int id, Map<String, dynamic> usuario) async {
    final db = await _db.database;
    return await db.update('usuarios', usuario, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }
}
