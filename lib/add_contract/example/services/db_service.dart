
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/contact.dart';


class DbService {
  static const _dbName = 'contacts.db';
  static const _table = 'contacts';
  static Database? _db;

  static Future<Database> _open() async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, _dbName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_table(
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            phone TEXT,
            email TEXT,
            company TEXT,
            notes TEXT,
            imagePath TEXT,
            createdAt TEXT NOT NULL
          );
        ''');
      },
    );
    return _db!;
  }

  static Future<void> upsert(Contact c) async {
    final db = await _open();
    await db.insert(_table, c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Contact>> all({String? query}) async {
    final db = await _open();
    List<Map<String, dynamic>> rows;
    if (query != null && query.trim().isNotEmpty) {
      final like = '%${query.trim()}%';
      rows = await db.query(
        _table,
        where: 'name LIKE ? OR phone LIKE ? OR email LIKE ? OR company LIKE ?',
        whereArgs: [like, like, like, like],
        orderBy: 'createdAt DESC',
      );
    } else {
      rows = await db.query(_table, orderBy: 'createdAt DESC');
    }
    return rows.map((e) => Contact.fromMap(e)).toList();
  }

  static Future<void> delete(String id) async {
    final db = await _open();
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
