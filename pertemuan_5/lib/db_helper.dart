import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart'; // Mengimpor kelas Catatan dari main.dart

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('catatan_mahasiswa.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE catatan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        isi TEXT NOT NULL,
        kategori TEXT NOT NULL,
        dibuat_pada INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insert(Catatan catatan) async {
    final db = await instance.database;
    return await db.insert('catatan', catatan.toMap());
  }

  Future<List<Catatan>> getAll() async {
    final db = await instance.database;
    final result = await db.query('catatan', orderBy: 'dibuat_pada DESC');

    return result.map((json) => Catatan.fromMap(json)).toList();
  }

  Future<int> update(Catatan catatan) async {
    final db = await instance.database;
    return await db.update(
      'catatan',
      catatan.toMap(),
      where: 'id = ?',
      whereArgs: [catatan.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'catatan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = _database; // Cukup panggil langsung tanpa 'await'
    if (db != null) {
      await db.close();
    }
  }
}