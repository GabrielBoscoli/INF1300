import 'package:bytebank/models/gasto.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class GastoDao {
  static const String _tableName = 'contacts';
  
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

  Future<int> update(Gasto gasto) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> gastoMap = _toMap(gasto);
    return db.update(
      _tableName,
      gastoMap,
      // TODO: atualizar clausula where
      // where: 'id = ?',
      // whereArgs: [gasto.id],
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
    // TODO: fazer o map corretamente.
    // gastoMap[_name] = gasto.name;
    // gastoMap[_accountNumber] = gasto.accountNumber;
    return gastoMap;
  }

  List<Gasto> _toList(List<Map<String, dynamic>> result) {
    final List<Gasto> gastos = [];
    for (Map<String, dynamic> row in result) {
      // TODO: criar o objeto Gasto e adicionar na lista
      // final Gasto gasto = Gasto(
      //   row[_id],
      //   row[_name],
      //   row[_accountNumber],
      // );
      // gastos.add(gasto);
    }
    return gastos;
  }
}