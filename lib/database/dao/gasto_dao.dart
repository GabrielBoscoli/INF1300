import 'dart:ui';

import 'package:bytebank/models/categoria.dart';
import 'package:bytebank/models/gasto.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class GastoDao {
  static const String _tableName = 'contacts';

  ///TODO: mudar o table name pra gasto
  static const String _id = 'id';
  static const String _valor = 'valor';
  static const String _descricao = 'descricao';
  static const String _categoriaNome = 'categoria';
  static const String _categoriaCor = 'categoriaCor';
  static const String _ano = 'ano';
  static const String _mes = 'mes';
  static const String _dia = 'dia';
  static const String _whereDateHigherOrEqual =
      '$_ano > ? OR ($_ano = ? AND $_mes > ?) OR ($_ano = ? AND $_mes = ? AND $_dia >= ?)';
  static const String _whereDateLowerOrEqual =
      '$_ano < ? OR ($_ano = ? AND $_mes < ?) OR ($_ano = ? AND $_mes = ? AND $_dia <= ?)';
  // TODO: futuramente extrair categoria para sua tabela propria, a fim de permitir multiplas categorias por gasto
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_valor REAL,'
      '$_descricao TEXT,'
      '$_categoriaNome TEXT,'
      '$_categoriaCor INTEGER,'
      '$_ano INTEGER,'
      '$_mes INTEGER,'
      '$_dia INTEGER)';

  const GastoDao();

  Future<int> save(Gasto gasto) async {
    final Database db = await getDatabase();
    Map<String, dynamic> gastoMap = _toMap(gasto);
    return db.insert(_tableName, gastoMap);
  }

  Future<List<Gasto>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Gasto> gastos = _toList(result);
    return gastos;
  }

  Future<double> findTotalByDate(DateTimeRange dateTimeRange) async {
    debugPrint('findTotalByDate');
    const columnName = 'TOTAL($_valor)';
    List<String> columns = [columnName];
    final List<Map<String, dynamic>> result =
        await _queryGastoByDateAux(dateTimeRange, columns);
    double total = result[0][columnName];
    return total;
  }

  Future<Map<Categoria, double>> findByDateGroupedByCategoria(
      DateTimeRange dateTimeRange) async {
    debugPrint('findByDateGroupedByCategoria');
    const columnTotal = 'TOTAL($_valor)';
    List<String> columns = [_categoriaNome, _categoriaCor, columnTotal];
    final List<Map<String, dynamic>> result =
        await _queryGastoByDateAux(dateTimeRange, columns, _categoriaNome);
    return _toMapCategoria(result, columnTotal);
  }

  Future<List<Map<String, dynamic>>> _queryGastoByDateAux(
      DateTimeRange dateTimeRange, List<String> columns,
      [String? groupBy]) async {
    /// separando os dados da data inicial
    DateTime start = dateTimeRange.start;
    final startDay = start.day;
    final startMonth = start.month;
    final startYear = start.year;

    /// separando os dados da data final
    DateTime end = dateTimeRange.end;
    final endDay = end.day;
    final endMonth = end.month;
    final endYear = end.year;

    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(
      _tableName,
      columns: columns,
      where: '($_whereDateHigherOrEqual) AND ($_whereDateLowerOrEqual)',
      whereArgs: [
        startYear,
        startYear,
        startMonth,
        startYear,
        startMonth,
        startDay,
        endYear,
        endYear,
        endMonth,
        endYear,
        endMonth,
        endDay
      ],
      groupBy: groupBy,
    );
    return result;
  }

  Future<int> update(Gasto gasto) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> gastoMap = _toMap(gasto);
    return db.update(
      _tableName,
      gastoMap,
      where: 'id = ?',
      whereArgs: [gasto.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> _toMap(Gasto gasto) {
    final Map<String, dynamic> gastoMap = Map();
    gastoMap[_categoriaNome] = gasto.categoria.name;
    gastoMap[_categoriaCor] = gasto.categoria.color.value;
    gastoMap[_descricao] = gasto.descricao;
    gastoMap[_ano] = gasto.data.year;
    gastoMap[_mes] = gasto.data.month;
    gastoMap[_dia] = gasto.data.day;
    gastoMap[_valor] = gasto.valor;
    return gastoMap;
  }

  List<Gasto> _toList(List<Map<String, dynamic>> result) {
    final List<Gasto> gastos = [];
    for (Map<String, dynamic> row in result) {
      final Gasto gasto = Gasto(
        row[_id],
        row[_valor],
        row[_descricao],
        Categoria(row[_categoriaNome], Color(row[_categoriaCor])),
        DateTime(row[_ano], row[_mes], row[_dia]),
      );
      gastos.add(gasto);
    }
    return gastos;
  }

  ///TODO: esse metodo vai mudar quando a categoria tiver tabela propria no futuro
  Map<Categoria, double> _toMapCategoria(
      List<Map<String, dynamic>> result, String columnTotal) {
    debugPrint('_toMapCategoria');
    Map<Categoria, double> resultMap = {};
    for (Map<String, dynamic> row in result) {
      final Categoria categoria = Categoria(
        row[_categoriaNome],
        Color(row[_categoriaCor]),
      );
      resultMap[categoria] = row[columnTotal];
    }
    return resultMap;
  }
}
