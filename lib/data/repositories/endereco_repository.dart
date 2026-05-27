import '../database/database_helper.dart';

class EnderecoRepository {
  final _db = DatabaseHelper();

  Future<int> inserir(Map<String, dynamic> endereco) async {
    final db = await _db.database;
    return await db.insert('enderecos', endereco);
  }

  Future<List<Map<String, dynamic>>> buscarPorUsuario(int usuarioId) async {
    final db = await _db.database;
    return await db.query('enderecos', where: 'usuario_id = ?', whereArgs: [usuarioId]);
  }

  Future<Map<String, dynamic>?> buscarPrincipal(int usuarioId) async {
    final db = await _db.database;
    final result = await db.query('enderecos', where: 'usuario_id = ? AND principal = 1', whereArgs: [usuarioId]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> atualizar(int id, Map<String, dynamic> endereco) async {
    final db = await _db.database;
    return await db.update('enderecos', endereco, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deletar(int id) async {
    final db = await _db.database;
    return await db.delete('enderecos', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> definirPrincipal(int usuarioId, int enderecoId) async {
    final db = await _db.database;
    await db.update('enderecos', {'principal': 0}, where: 'usuario_id = ?', whereArgs: [usuarioId]);
    await db.update('enderecos', {'principal': 1}, where: 'id = ?', whereArgs: [enderecoId]);
  }
}
