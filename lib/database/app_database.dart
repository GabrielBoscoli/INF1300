import 'package:bytebank/database/dao/categoria_dao.dart';
import 'package:bytebank/database/dao/gasto_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'inf.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(GastoDao.tableSql);
      db.execute(CategoriaDao.tableSql);
    },
    version: 1,
  );
}
