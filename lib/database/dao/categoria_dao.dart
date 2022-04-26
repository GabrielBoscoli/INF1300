import 'dart:ui';

import 'package:bytebank/models/categoria.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class CategoriaDao {
  static const _tableName = 'categoria';
  static const _nome = 'nome';
  static const _cor = 'cor';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_nome TEXT PRIMARY KEY, '
      '$_cor INTEGER)';

  const CategoriaDao();

  Future<int> save(Categoria categoria) async {
    final Database db = await getDatabase();
    Map<String, dynamic> categoriaMap = _toMap(categoria);
    return db.insert(_tableName, categoriaMap);
  }

  Future<List<Categoria>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Categoria> categorias = _toList(result);
    return categorias;
  }

  Future<int> update(Categoria categoria) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> categoriaMap = _toMap(categoria);
    return db.update(
      _tableName,
      categoriaMap,
      where: '$_nome = ?',
      whereArgs: [categoria.name],
    );
  }

  Future<int> delete(String nome) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_nome = ?',
      whereArgs: [nome],
    );
  }

  Map<String, dynamic> _toMap(Categoria categoria) {
    final Map<String, dynamic> categoriaMap = Map();
    categoriaMap[_nome] = categoria.name;
    categoriaMap[_cor] = categoria.color.value;
    return categoriaMap;
  }

  List<Categoria> _toList(List<Map<String, dynamic>> result) {
    final List<Categoria> categorias = [];
    for (Map<String, dynamic> row in result) {
      final Categoria categoria = Categoria(
        row[_nome],
        Color(row[_cor]),
      );
      categorias.add(categoria);
    }
    return categorias;
  }
}
