import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() async {
  final dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'bytebank.db');
  openDatabase(path, onCreate: (db, version) {
    db.execute('CREATE TABLE gasto('
        'id INTEGER PRIMARY KEY, '
        'name TEXT,'
        'account_number INTEGER)'); // depois definir os atributos da tabela corretamente
  }, version: 1);
}
