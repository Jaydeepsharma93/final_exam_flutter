import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'liked_notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE liked_notes(
            id TEXT PRIMARY KEY,
            title TEXT,
            note TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertLikedNote(Map<String, dynamic> note) async {
    final db = await database;
    await db.insert(
      'liked_notes',
      note,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getLikedNotes() async {
    final db = await database;
    return await db.query('liked_notes');
  }

  Future<void> deleteLikedNote(String id) async {
    final db = await database;
    await db.delete(
      'liked_notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
