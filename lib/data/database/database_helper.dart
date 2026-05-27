import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String caminho;
    if (kIsWeb) {
      caminho = 'femmehub.db';
    } else {
      final dir = await getDatabasesPath();
      caminho = p.join(dir, 'femmehub.db');
    }

    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        senha TEXT NOT NULL,
        tipo TEXT NOT NULL,
        telefone TEXT,
        data_criacao TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE enderecos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        endereco TEXT NOT NULL,
        bairro TEXT NOT NULL,
        numero TEXT NOT NULL,
        complemento TEXT,
        principal INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        codigo INTEGER NOT NULL UNIQUE,
        descricao TEXT NOT NULL,
        preco_unitario REAL NOT NULL,
        unidade_medida TEXT NOT NULL,
        data_criacao TEXT NOT NULL,
        data_atualizacao TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE fornecedores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        cnpj TEXT NOT NULL UNIQUE,
        telefone TEXT NOT NULL,
        email TEXT NOT NULL,
        endereco TEXT NOT NULL,
        data_criacao TEXT NOT NULL,
        data_atualizacao TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        endereco_id INTEGER,
        tipo_entrega TEXT NOT NULL,
        valor_total REAL NOT NULL,
        data_criacao TEXT NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
        FOREIGN KEY (endereco_id) REFERENCES enderecos(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE itens_pedido (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pedido_id INTEGER NOT NULL,
        produto_id INTEGER NOT NULL,
        quantidade INTEGER NOT NULL,
        preco_unitario REAL NOT NULL,
        FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
        FOREIGN KEY (produto_id) REFERENCES produtos(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE produto_fornecedor (
        produto_id INTEGER NOT NULL,
        fornecedor_id INTEGER NOT NULL,
        PRIMARY KEY (produto_id, fornecedor_id),
        FOREIGN KEY (produto_id) REFERENCES produtos(id),
        FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
      )
    ''');
  }
}
