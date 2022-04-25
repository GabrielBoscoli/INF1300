import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  debugPrint('getDatabase()');
  final dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      debugPrint('criando banco de dados...');
      db.execute(GastoDao.tableSql);
    },
    version: 1,
  );
}
