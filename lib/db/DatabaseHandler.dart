import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/Favorilerim.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'atakan.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE favorilerim(id INTEGER PRIMARY KEY AUTOINCREMENT,"
          " yemekAdi TEXT NOT NULL"
          ",yemekURL TEXT NOT NULL"
          ",tarifURL TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertFavorilerim(Favorilerim favorilerim) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('favorilerim', favorilerim.toMap());
    return result;
  }

  Future<List<Favorilerim>> getFavorilerim() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('favorilerim');
    return queryResult.map((e) => Favorilerim.fromMap(e)).toList();
  }

  Future<void> deleteFavorilerim(int id) async {
    final db = await initializeDB();
    await db.delete(
      'favorilerim',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
